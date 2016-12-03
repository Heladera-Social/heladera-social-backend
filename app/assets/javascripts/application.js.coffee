# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require bootstrap-sprockets
#= require chosen-jquery
#= require turbolinks
#= require underscore
#= require bootstrap-datepicker
#= require jquery_nested_form
#= require_tree .

markers = []

$(window).load ->
  map = undefined
  initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      center:
        lat: -34.6037
        lng: -58.3816
      zoom: 8)
  if $("#edit-directions").data()
    debugger
    lat = parseFloat $("#edit-directions").data().lat
    lng = parseFloat $("#edit-directions").data().long
    console.log lat
    console.log lng
    gMap = new (google.maps.Map)(document.getElementById('map'))
    gMap.setZoom 15
    gMap.setCenter new (google.maps.LatLng)(lat, lng)
    newMarker = new (google.maps.Marker)(
      map: gMap
      position: new (google.maps.LatLng)(lat, lng))
    markers.push(newMarker)
    gMap.addListener 'click', (e) ->
      i = 0
      while i < markers.length
        markers[i].setMap null
        i++
      newMarker = new (google.maps.Marker)(
        map: gMap
        position: e.latLng)
      markers.push(newMarker)
      gMap.setCenter newMarker.getPosition()
      $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
      $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
      return
  else if  $("#direccion").data()
    lat = parseFloat $("#direccion").data().lat
    lng = parseFloat $("#direccion").data().long
    console.log lat
    console.log lng
    gMap = new (google.maps.Map)(document.getElementById('map'))
    gMap.setZoom 15
    gMap.setCenter new (google.maps.LatLng)(lat, lng)
    newMarker = new (google.maps.Marker)(
      map: gMap
      position: new (google.maps.LatLng)(lat, lng))
  else if $("#storage_unit_latitude")
    gMap = new (google.maps.Map)(document.getElementById('map'))
    gMap.setZoom 12
    gMap.setCenter new (google.maps.LatLng)(-34.6037, -58.3816)
    gMap.addListener 'click', (e) ->
      i = 0
      while i < markers.length
        markers[i].setMap null
        i++
      newMarker = new (google.maps.Marker)(
        map: gMap
        position: e.latLng)
      markers.push(newMarker)
      gMap.setCenter newMarker.getPosition()
      $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
      $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
      return
  
