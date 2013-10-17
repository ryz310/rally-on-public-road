user01 = "001"
urlRoot          = "http://rallyonpublicroad.azurewebsites.net/"
urlUser          = urlRoot + "api/user"
urlRally         = urlRoot + "api/Rally"
urlCheckPoint    = urlRoot + "api/CheckPoint?rallyId="
urlTag           = urlRoot + "api/Tag"
urlParticipate   = urlRoot + "api/participateRally?userId=" + user01
urlPriusLocation = urlRoot + "tiwa/getPriusLocation"
urlStreetView    = "http://maps.googleapis.com/maps/api/streetview?sensor=false"

# Ajax による JSONP 取得用メソッド
myAjax = (apiUrl, successAction, errorAction = ->) ->
  $.ajax
    type:     "GET"
    url:      apiUrl
    dataType: "jsonp"
    success:  (json) ->
      console.log "success: " + apiUrl
      successAction json
    error: ->
      console.log "error: "   + apiUrl
      errorAction()

# YMAPのインスタンス
@ymap = undefined

# YMAP 初期化
initMap = (ymap) ->
  ymap.setConfigure 'dragging',       true
  ymap.setConfigure 'singleClickPan', true
  ymap.setConfigure 'doubleClickZoom',true
  ymap.setConfigure 'continuousZoom', true
  ymap.setConfigure 'scrollWheelZoom',true

  myAjax urlPriusLocation, ((json) -> 
    ymap.drawMap new Y.LatLng(json.Latitude, json.Longitude), 12, Y.LayerSetId.NORMAL
  ), ->
    ymap.drawMap new Y.LatLng(  35.39291572,   139.44288869),  7, Y.LayerSetId.NORMAL
    
# マーカーを MAP 上に追加
markup = (latlng, message, icon = Y.Icon.DEFAULT_ICON) ->
  title = "<p>" + message + "</p>" + "<img src='" + streetViewUrl(latlng, 120, 90) + "' />"
  marker = new Y.Marker latlng, title: title, icon: icon
  marker.bind 'click', =>
    target = $ "#street_view"
    target.empty()
    target.append "<img src='" + streetViewUrl(latlng, 480, 360) + "' />"
  @ymap.addFeature marker

# Google Street View Image API 画像URL
streetViewUrl = (latlng, width = 280, height = 180) ->
  urlStreetView + "&location=" + latlng.lat() + "," + latlng.lng() + "&size=" + width + "x" + height

# <li>タグを更新
updateListItem = (targetListId, sourceUrl) ->
  myAjax sourceUrl, (json) ->
    target = $ targetListId
    target.empty()
    json.forEach (x) -> 
      target.append "<li>" + "<a href='#' onclick='drowCheckPoint(" + x.Id.substr(5, 3) + ");return false;'>" + x.Name + "</a>"

# チェックポイントを描画
@drowCheckPoint = (rallyID) ->
  myAjax urlCheckPoint + rallyID, (json) ->
    @ymap.clearFeatures()
    json.forEach (x) ->
      latlng = new Y.LatLng x.Latitude, x.Longitude
      @ymap.setZoom 15, true, latlng, true
      @ymap.panTo   latlng, true
      markup latlng, "<b>" + x.Name + "</b>" + "<br />" + x.Discription 

# タグを描画
@drowTag = ->
  myAjax urlTag, (json) ->
    json.forEach (x) ->
      latlng = new Y.LatLng x.Latitude, x.Longitude
      @ymap.setZoom 16, true, latlng, true
      # img = x.ImagePath
      markup latlng, x.UserName + "<br />" + x.Message

# 初期化
$(document).ready =>
  @ymap = new Y.Map "map"
  
  # マップ情報初期化
  initMap @ymap

  # <li>タグ情報更新
  updateListItem "#rally_participate", urlParticipate
  updateListItem "#rally_list",        urlRally
  