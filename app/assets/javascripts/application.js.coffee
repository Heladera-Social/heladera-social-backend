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
#= require underscore
#= require bootstrap-datepicker
#= require jquery_nested_form
#= require_tree .

markers = []

$(document).on 'nested:fieldAdded', (event) ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No hay resultados'
    width: '200px'
  fields = $(".fields")
  text = ""
  for i in [0...fields.length-1]
    value = fields[i].getElementsByClassName('chosen-select')[0].value
    if value 
      text += "<p>" + fields[i].getElementsByClassName('quantity')[0].value + " X " + fields[i].getElementsByClassName('chosen-select')[0].options[parseInt(value)].text + "</p>"
  $("#products")[0].innerHTML = " "
  $("#products")[0].innerHTML = text
  return

$(document).on 'nested:fieldRemoved', (event) ->
  fields = $(".fields")
  text = " "
  $("#products")[0].innerHTML = " "
  for i in [0...fields.length-1]
    value = fields[i].getElementsByClassName('chosen-select')[0].value
    if value && event.field[0] != fields[i]
      text += "<p>" + fields[i].getElementsByClassName('quantity')[0].value + " X " + fields[i].getElementsByClassName('chosen-select')[0].options[parseInt(value)].text + "</p>"
  $("#products")[0].innerHTML = text
  return

$('.chosen-select').on 'change', (e) ->
  debugger
  fields = $(".fields")
  text = ""
  for i in [0...fields.length-1]
    value = fields[i].getElementsByClassName('chosen-select')[0].value
    if value 
      text += "<p>" + fields[i].getElementsByClassName('quantity')[0].value + " X " + fields[i].getElementsByClassName('chosen-select')[0].options[parseInt(value)].text + "</p>"
  $("#products")[0].innerHTML = " "
  $("#products")[0].innerHTML = text
  return


$(window).load ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No hay resultados'
    width: '200px'
  map = undefined
  initMap = ->
    map = new (google.maps.Map)(document.getElementById('map'),
      center:
        lat: -34.6037
        lng: -58.3816
      zoom: 8)
  if $("#edit-directions").data()
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
        draggable: true
        position: e.latLng)
      markers.push(newMarker)
      gMap.setCenter newMarker.getPosition()
      $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
      $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
      return
    # Create the search box and link it to the UI element.
    input = $(".pac-input")[0]
    searchBox = new (google.maps.places.SearchBox)(input)
    searchBox.addListener 'places_changed', ->
      places = searchBox.getPlaces()
      if places.length == 0
        return
      bounds = new (google.maps.LatLngBounds)
      places.forEach (place) ->
        if place.geometry.viewport
          # Only geocodes have viewport.
          bounds.union place.geometry.viewport
          i = 0
          while i < markers.length
            markers[i].setMap null
            i++
          newMarker = new (google.maps.Marker)(
            map: gMap
            draggable: true
            position: new (google.maps.LatLng)(place.geometry.location.lat(), place.geometry.location.lng()))
          markers.push(newMarker)
          gMap.setCenter newMarker.getPosition()
          $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
          $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
        else
          bounds.extend place.geometry.location
        return
      gMap.fitBounds bounds
      return
  else if  $("#storage_units").data()
    gMap = new (google.maps.Map)(document.getElementById('map'))
    gMap.setZoom 12
    gMap.setCenter new (google.maps.LatLng)(-34.6037, -58.3816)
    storages = $("#storage_units").data().storages
    for storage in storages
      lat = parseFloat storage.latitude
      lng = parseFloat storage.longitude 
      newMarker = new (google.maps.Marker)(
        map: gMap
        position: new (google.maps.LatLng)(lat, lng)
        url: "http://heladera-social.herokuapp.com/storage_units/"+storage.id)
      google.maps.event.addListener newMarker, 'click', ->
        window.location.href = @url
        return
    # Create the search box and link it to the UI element.
    input = document.getElementById('pac-input')
    searchBox = new (google.maps.places.SearchBox)(input)
    gMap.controls[google.maps.ControlPosition.TOP_LEFT].push input
    # Bias the SearchBox results towards current map's viewport.
    gMap.addListener 'bounds_changed', ->
      searchBox.setBounds gMap.getBounds()
      return
    searchBox.addListener 'places_changed', ->
      places = searchBox.getPlaces()
      if places.length == 0
        return
      bounds = new (google.maps.LatLngBounds)
      places.forEach (place) ->
        if place.geometry.viewport
          # Only geocodes have viewport.
          bounds.union place.geometry.viewport
        else
          bounds.extend place.geometry.location
        return
      gMap.fitBounds bounds
      return
  else if  $("#direccion").data()
    lat = parseFloat $("#direccion").data().lat
    lng = parseFloat $("#direccion").data().long
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
        draggable: true
        position: e.latLng)
      markers.push(newMarker)
      gMap.setCenter newMarker.getPosition()
      $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
      $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
      return
    # Create the search box and link it to the UI element.
    input = $(".pac-input")[0]
    searchBox = new (google.maps.places.SearchBox)(input)
    searchBox.addListener 'places_changed', ->
      places = searchBox.getPlaces()
      if places.length == 0
        return
      bounds = new (google.maps.LatLngBounds)
      places.forEach (place) ->
        if place.geometry.viewport
          # Only geocodes have viewport.
          bounds.union place.geometry.viewport
          i = 0
          while i < markers.length
            markers[i].setMap null
            i++
          newMarker = new (google.maps.Marker)(
            map: gMap
            draggable: true
            position: new (google.maps.LatLng)(place.geometry.location.lat(), place.geometry.location.lng()))
          markers.push(newMarker)
          gMap.setCenter newMarker.getPosition()
          $("#storage_unit_latitude")[0].value = newMarker.getPosition().lat()
          $("#storage_unit_longitude")[0].value = newMarker.getPosition().lng()
        else
          bounds.extend place.geometry.location
        return
      gMap.fitBounds bounds
      return
  $("#loader").fadeOut(1000);

  

  
