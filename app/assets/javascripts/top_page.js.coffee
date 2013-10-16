user01 = "001"
urlRoot          = "http://rallyonpublicroad.azurewebsites.net/"
urlUser          = urlRoot + "api/user"
urlRally         = urlRoot + "api/Rally"
urlCheckPoint    = urlRoot + "api/CheckPoint?rallyId="
urlTag           = urlRoot + "api/Tag"
urlParticipate   = urlRoot + "api/participateRally?userId=" + user01
urlPriusLocation = urlRoot + "tiwa/getPriusLocation"

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
    ymap.drawMap new Y.LatLng(  35.39291572,   139.44288869), 12, Y.LayerSetId.NORMAL
    
# マーカーを MAP 上に追加
markup = (latlng, message, icon = Y.Icon.DEFAULT_ICON) ->
  marker = new Y.Marker latlng, title: message, icon: icon
  @ymap.addFeature marker

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
      markup latlng, x.UserName + "<br />" + x.Message, new Y.Icon(x.ImagePath)
    

# <li>タグを更新
@updateListItem = (targetListId, sourceUrl) ->
  myAjax sourceUrl, (json) ->
    target = $ targetListId
    target.empty()
    json.forEach (x) -> 
      target.append "<li>" + "<a href='#' onclick='drowCheckPoint(" + x.Id.substr(5, 3) + ");return false;'>" + x.Name + "</a>"

# 初期化
$(document).ready =>
  @ymap = new Y.Map "map"
  
  # マップ情報初期化
  initMap @ymap

  # <li>タグ情報更新
  @updateListItem "#rally_participate", urlParticipate
  @updateListItem "#rally_list",        urlRally
  