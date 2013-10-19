user01 = "001"
urlRoot          = "http://rallyonpublicroad.azurewebsites.net/"
urlUser          = urlRoot + "api/user"
urlRally         = urlRoot + "api/Rally"
urlCheckPoint    = urlRoot + "api/CheckPoint?rallyId="
urlTag           = urlRoot + "api/Tag"
urlParticipate   = urlRoot + "api/participateRally?userId=" + user01
urlPriusLocation = urlRoot + "api/getPriusLocation"
urlStreetView    = "http://maps.googleapis.com/maps/api/streetview?sensor=true"
imgCheckerFlag   = "http://res.cloudinary.com/htx0gxzfc/image/upload/v1382207011/checkerflag_xkkh9q.png"
imgSCheckerFlag  = "http://res.cloudinary.com/htx0gxzfc/image/upload/v1382207011/s_checkerflag_pkb3js.png"
imgPriusTan      = "http://res.cloudinary.com/htx0gxzfc/image/upload/c_scale,w_160/v1382103868/prius-tan_pgwkgs.jpg"

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
ymap = undefined

# YMAP 初期化
initYMap = ->
  ymap = new Y.Map "map"
  ymap.setConfigure 'dragging',       true
  ymap.setConfigure 'singleClickPan', true
  ymap.setConfigure 'doubleClickZoom',true
  ymap.setConfigure 'continuousZoom', true
  ymap.setConfigure 'scrollWheelZoom',true
  ymap.drawMap new Y.LatLng(35.39291572, 139.44288869), 7, Y.LayerSetId.NORMAL
   
drowPrius = ->
  myAjax urlPriusLocation, (json) ->
    latlng = new Y.LatLng(json[0].Latitude, json[0].Longitude)
    ymap.clearFeatures()
    markup latlng, "プリウスたんの現在位置<br /><img src='" + imgPriusTan + "' />"
    ymap.panTo latlng, true
    updateStreetView latlng

# マーカーを MAP 上に追加
markup = (latlng, message, enableStreetView = false, icon = Y.Icon.DEFAULT_ICON) ->
  title = "<p>" + message + "</p>"
  if enableStreetView
    title += "<img src='" + streetViewUrl(latlng, 120, 90) + "' />"
  marker = new Y.Marker latlng, title: title, icon: icon
  marker.bind 'click', =>
    ymap.panTo latlng, true
    updateStreetView latlng
  ymap.addFeature marker

# Google Street View Image API 画像URL
streetViewUrl = (latlng, width = 280, height = 180) ->
  urlStreetView + "&location=" + latlng.lat() + "," + latlng.lng() + "&size=" + width + "x" + height

# <li>タグを更新
updateListItem = (targetListId, sourceUrl) ->
  myAjax sourceUrl, (json) ->
    target = $ targetListId
    target.empty()
    json.forEach (x) ->
      target.append "<li>" + "<a href='#' onclick='drowCheckPoint(" + x.RallyId.substr(5, 3) + ");return false;'>" + x.Name + "</a>"

# StreetView 表示領域を更新
updateStreetView = (latlng) ->
  img = new Image()
  img.onload = ->
    clearStreetView()
    $("#street_view").append img
  img.onerror = ->
    console.log "image load error"
  img.src = streetViewUrl latlng, 480, 360
    
clearStreetView = ->
  $("#street_view").empty()
    
# チェックポイントを描画
time_span = 1000
@drowCheckPoint = (rallyID) ->
  myAjax urlCheckPoint + rallyID, (json) ->
    ymap.clearFeatures()
    ymap.setZoom 15, true
    lat_sum = 0
    lng_sum = 0
    json.forEach (x, i) ->
      latlng = new Y.LatLng x.Latitude, x.Longitude
      lat_sum += x.Latitude
      lng_sum += x.Longitude
      setTimeout (->
        message = "<b>" + x.Name + "</b>" + "<br />" + x.Discription
        markup latlng, message, true, new Y.Icon imgSCheckerFlag
        ymap.openInfoWindow latlng, message
        ymap.panTo latlng, true
      ), time_span * i
    center = new Y.LatLng lat_sum / json.length, lng_sum / json.length
    setTimeout (->
      ymap.setZoom 12, false, center, true
      ymap.closeInfoWindow()
    ), time_span * json.length
    
# タグを描画
@drowTag = ->
  myAjax urlTag, (json) ->
    lat_sum = 0
    lng_sum = 0
    json.forEach (x) ->
      latlng = new Y.LatLng x.Latitude, x.Longitude
      lat_sum += x.Latitude
      lng_sum += x.Longitude
      message = "<b>" + x.UserName + "</b>" + "<br />" + x.Message
      markup latlng, message, true, new Y.Icon imgCheckerFlag
    center = new Y.LatLng lat_sum / json.length, lng_sum / json.length
    ymap.setZoom 15, true, center, true

# TimeLine に Tweet を追加する
addTweet = (tweet) ->
  $(tweet).prependTo("div.timeline-content").fadeIn()

# Tweet の内容を地図上に表示する
@newMessage = (tweet, lat, lng) ->
  latlng = new Y.LatLng lat, lng
  ymap.panTo latlng
  ymap.openInfoWindow latlng, tweet
  addTweet tweet
  setTimeout (->
    ymap.closeInfoWindow()
  ), 5000

# プリウスを地図上に追跡する
trackingTimer = undefined
@trackingPrius = ->
  drowPrius()
  trackingTimer = setInterval (->
    drowPrius()
  ), 3000

# プリウスの追跡を終了する
@trackingStop = ->
  clearInterval trackingTimer
  clearStreetView()

# 初期化
$(document).ready =>
  # マップ情報初期化
  initYMap()
  
  # <li>タグ情報更新
  updateListItem "#rally_participate", urlParticipate
  updateListItem "#rally_list",        urlRally
  