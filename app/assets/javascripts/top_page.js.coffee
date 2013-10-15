@ymap = undefined

class Ymap
  constructor: (lat, lon) ->
    @map = new Y.Map("map")
    @map.drawMap new Y.LatLng(lat, lon), 12, Y.LayerSetId.NORMAL
  
  markup: (lat, lon, message) =>
    mark = new Y.Marker(new Y.LatLng(lat, lon), title: message)
    @map.addFeature mark

window.onload = ->
  $.ajax
    type: "GET"
    #        url: "https://api-jp-t-itc.com/DataSender/services/GetVehicleInfo?apilkey=8cf828ec240&vid=DLA-ZVW35-3125211&MapMatching=1",
    url: "http://localhost:3000/info.xml"
    dataType: "xml"
    success: (xml_data) =>
      console.log "success"
      lat = $(xml_data).find("lat").text()
      lon = $(xml_data).find("lon").text()
      @ymap = new Ymap(lat, lon)
      @ymap.markup(lat, lon, "hoge")
      console.log @ymap
      # mark = new Y.Marker(new Y.LatLng(lat, lon))
      # @ymap.addFeature mark
      # @ymap.addFeature new Y.Marker(new Y.LatLng(35.769269500, 139.836911167))
      # @ymap.addFeature new Y.Marker(new Y.LatLng(35.629269500, 139.836911167))
    error: ->
      console.log "error"
