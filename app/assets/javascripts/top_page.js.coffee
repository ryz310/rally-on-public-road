user01 = "001"
url = "http://rallyonpublicroad.azurewebsites.net/"
url_user  = url + "api/user"
url_rally = url + "api/Rally"
url_cp    = url + "api/CheckPoint"
url_tag   = url + "api/Tag"
url_join  = url + "api/participateRally?userId=" + user01
url_gps  = "http://localhost:3000/info.xml" 

class Ymap
  constructor: (lat, lon) ->
    @map = new Y.Map("map")
    @map.drawMap new Y.LatLng(lat, lon), 12, Y.LayerSetId.NORMAL
  
  markup: (lat, lon, message) =>
    console.log 'Ymap.markup is run'
    console.log @map
    mark = new Y.Marker(new Y.LatLng(lat, lon), title: message)
    @map.addFeature mark

@ymap = undefined

@markup = (lat, lon, message) ->
  @ymap.markup lat, lon, message

$(document).ready =>
  @ymap = new Ymap 35.769269500, 139.836911167
  
  $.ajax
    type: "GET"
    #        url: "https://api-jp-t-itc.com/DataSender/services/GetVehicleInfo?apilkey=8cf828ec240&vid=DLA-ZVW35-3125211&MapMatching=1",
    url:      url_gps
    dataType: "xml"
    success: (xml_data) =>
      console.log "ymap success"
      lat = $(xml_data).find("lat").text()
      lon = $(xml_data).find("lon").text()
    error: ->
      console.log "ymap error"

  $.ajax
    type: "GET"
    url: url_rally
    dataType: "json"
    success: (json) ->
      console.log "user info success!"
      console.log json
    error: (data) ->
      console.log "user info error"
