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
#= require gmaps/google
#= require_tree .
$ ->
  $('#login-form-link').click (e) ->
    $('#login-form').delay(100).fadeIn 100
    $('#register-form').fadeOut 100
    $('#register-form-link').removeClass 'active'
    $(this).addClass 'active'
    e.preventDefault()
    return
  $('#register-form-link').click (e) ->
    $('#register-form').delay(100).fadeIn 100
    $('#login-form').fadeOut 100
    $('#login-form-link').removeClass 'active'
    $(this).addClass 'active'
    e.preventDefault()
    return
  return
createSidebarLi = (json) ->
  '<li><a>' + json.name + '</a></li>'

bindLiToMarker = ($li, marker) ->
  $li.on 'click', ->
    handler.getMap().setZoom 14
    marker.setMap handler.getMap()
    #because clusterer removes map property from marker
    marker.panTo()
    google.maps.event.trigger marker.getServiceObject(), 'click'
    return
  return

createSidebar = (json_array) ->
  _.each json_array, (json) ->
    $li = $(createSidebarLi(json))
    $li.appendTo '#sidebar_container'
    bindLiToMarker $li, json.marker
    return
  return

handler = Gmaps.build('Google')
handler.buildMap { internal: id: 'sidebar_builder' }, ->
  json_array = [
    {
      lat: -34.5620844
      lng: -58.4588766
      name: 'Bache'
      infowindow: 'Avenida Cabildo y Juramento. Denunciado por @Juan. Estado: Pendiente de resolver. Fecha 11/05/16'
    }
    {
      lat: -34.6307264
      lng: -58.4718442
      name: 'Iluminacion'
      infowindow: 'Avenida Rivadavia y Avenida Nazca. Denunciado por @Maria. Estado: Resuelto. Fecha: 18/05/16'
    }
    {
      lat: -34.6412239
      lng: -58.5496334
      name: 'Obra sin permiso'
      infowindow: 'Diaz Velez 123. Denunciado por @Roberto. Estado: Pendiente de resolver. Se han sumado 47 personas a este pedido. Fecha: 1/3/16'
    }
  ]
  markers = handler.addMarkers(json_array)
  _.each json_array, (json, index) ->
    json.marker = markers[index]
    return
  createSidebar json_array
  handler.bounds.extendWith markers
  handler.fitMapToBounds()
  return

###
handler = Gmaps.build('Google')
handler.buildMap { internal: id: 'multi_markers' }, ->
  markers = handler.addMarkers([
    {
      lat: 43
      lng: 3.5
    }
    {
      lat: 45
      lng: 4
    }
    {
      lat: 47
      lng: 3.5
    }
    {
      lat: 49
      lng: 4
    }
    {
      lat: 51
      lng: 3.5
    }
  ])
  handler.bounds.extendWith markers
  handler.bounds
  handler.fitMapToBounds()
  return

  	map = undefined
	initMap = ->
	  map = new (google.maps.Map)(document.getElementById('map'),
	    center:
	      lat: -34.6037
	      lng: -58.3816
	    zoom: 8)
	  myLatLng = 
	    lat: -34.6037
	    lng: -58.3816
	  $('#localities').each ->
	  	val = $(this).val().split ";"
	  	console.log 
	  	lat = parseFloat val[0]
	  	lng = parseFloat val[1]
	  	marker = new (google.maps.Marker)(
	  	  position: myLatLng
	  	  map: map
	  	  title: 'Hello World!')
		
	
	$('#localities').on "change", ->
		value = $(this).val().split ";"
		lat = parseFloat value[0]
		lng = parseFloat value[1]
		gMap = new (google.maps.Map)(document.getElementById('map'))
		gMap.setZoom 15
		# This will trigger a zoom_changed on the map
		gMap.setCenter new (google.maps.LatLng)(lat, lng)
		newMarker = new (google.maps.Marker)(
		  map: map
		  animation: google.maps.Animation.DROP
		  position: new (google.maps.LatLng)(lat, lng))
###