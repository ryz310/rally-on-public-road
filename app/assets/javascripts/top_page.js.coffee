user01 = "001"
url       = "http://rallyonpublicroad.azurewebsites.net/"
url_user  = url + "api/user"
url_rally = url + "api/Rally"
url_cp    = url + "api/CheckPoint?rallyId="
url_tag   = url + "api/Tag"
url_join  = url + "api/participateRally?userId=" + user01
url_gps   = url + "tiwa/getPriusLocation"

# YMAPのインスタンス
@ymap = undefined

# YMAP 初期化
initMap = (ymap) ->
  ymap.setConfigure 'dragging',       true
  ymap.setConfigure 'singleClickPan', true
  ymap.setConfigure 'doubleClickZoom',true
  ymap.setConfigure 'continuousZoom', true
  ymap.setConfigure 'scrollWheelZoom',true
  $.ajax
    type: "GET"
    url:      url_gps
    dataType: "xml"
    success: (xmlData) ->
      console.log "ymap success"
      lat = $(xmlData).find("lat").text()
      lon = $(xmlData).find("lon").text()
      ymap.drawMap new Y.LatLng(lat, lon), 12, Y.LayerSetId.NORMAL
    error: ->
      console.log "initMap error"
      ymap.drawMap new Y.LatLng(35.39291572, 139.44288869), 8, Y.LayerSetId.NORMAL

# マーカーを MAP 上に追加
markup = (lat, lon, message) ->
  latlng = new Y.LatLng(lat, lon)
  marker = new Y.Marker latlng
  @ymap.addFeature marker, title: message

# チェックポイントを描画
@drowCheckPoint = (rallyID) ->
  $.ajax
    type:     "GET"
    url:      url_cp + rallyID
    dataType: "jsonp"
    success: (json) =>
      @ymap.clearFeatures()
      json.forEach (x) ->
        latlng = new Y.LatLng x.Latitude, x.Longitude
        @ymap.setZoom 15, true, latlng, true
        @ymap.panTo latlng, true
        markup x.Latitude, x.Longitude, x.Name
    error: ->
      console.log "@drowCheckPoint error"

# <li>タグを更新
@updateListItem = (targetListId, sourceUrl) ->
  $.ajax
    type: "GET"
    url:  sourceUrl
    dataType: "jsonp"
    success: (json) ->
      target = $ targetListId
      target.empty()
      json.forEach (x) -> 
        target.append "<li>" + "<a href='#' onclick='drowCheckPoint(" + x.Id.substr(5, 3) + ");return false;'>" + x.Name + "</a>"
    error: ->
      console.log "@updateListItem error."

# 初期化
$(document).ready =>
  @ymap = new Y.Map "map"
  
  # マップ情報初期化
  initMap @ymap

  # <li>タグ情報更新
  @updateListItem "#rally_participate", url_join
  @updateListItem "#rally_list",        url_rally
  