# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

markers = []

route_controler = ""

green_icon = () ->
  greenIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-green.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

grey_icon = () ->
  greyIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-grey.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

black_icon = () ->
  backIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-black.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

orange_icon = () ->
  orangeIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-orange.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

red_icon = () ->
  redIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-red.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

yellow_icon = () ->
  yellowIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-yellow.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

blue_icon = () ->
  blueIcon = new L.icon ({
    iconUrl: '/assets/marker-icon-2x-blue.png',
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41] })

clean_map = () ->
  #remove all markers
  for marker in markers
    window.map.removeLayer marker

  if route_controler isnt ""
    window.map.removeControl route_controler


init_map = () ->
  window.map = L.map('mapid')
  window.map.setView([48.13, 17.13], 13)

  L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoicmFtaW10aSIsImEiOiJjaXZyNXNvOHQwMDFzMnptbmQ1dnV0cDBtIn0.Ajsde0n4gi9sA81bnPuK1A', {
    maxZoom: 18,
    id: '256',
    accessToken: 'pk.eyJ1IjoicmFtaW10aSIsImEiOiJjaXZyNXNvOHQwMDFzMnptbmQ1dnV0cDBtIn0.Ajsde0n4gi9sA81bnPuK1A'
  }).addTo(window.map);

$(document).ready ->
  init_map()

  $("#search_coord").click ->
    form = $(".simple_form.search_coord")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        clean_map()

        console.log(results)
        objects = []

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)
          if result.name is null
            result.name="Unknown"
            marker = L.marker(geo_data.coordinates.reverse(), icon: grey_icon()).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: green_icon()).addTo(window.map)

          marker.bindPopup("<b>" + result.name + "</b>" + "</br>" + geo_data.coordinates.reverse())

          markers.push marker
          objects.push marker

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)

  $("#search_submit").click ->
    form = $(".simple_form.search")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        clean_map()

        console.log(results)
        objects = []

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)
          if result.name is null
            result.name="Unknown"
            marker = L.marker(geo_data.coordinates.reverse(), icon: grey_icon()).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: green_icon()).addTo(window.map)

          marker.bindPopup("<b>" + result.name + "</b>" + "</br>" +  geo_data.coordinates.reverse())
          objects.push marker

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)

  $("#insert_node_button").click ->
    form = $(".simple_form.insert_node_form")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        clean_map()

        console.log(results)
        objects = []

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)
          if result.name is null
            result.name="Unknown"
            marker = L.marker(geo_data.coordinates.reverse(), icon: grey_icon()).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: green_icon()).addTo(window.map)

          marker.bindPopup("<b>" + result.name + "</b>" + "</br>" +  geo_data.coordinates.reverse())
          objects.push marker

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)

  $("#search_coord_historic").click ->
    form = $(".simple_form.search_coord_historic")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        clean_map()

        console.log(results)
        objects = []

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)

          if result.historic is "castle"
            marker = L.marker(geo_data.coordinates.reverse(), icon: black_icon()).addTo(window.map)
          else if result.historic is "battlefield"
            marker = L.marker(geo_data.coordinates.reverse(), icon: red_icon()).addTo(window.map)
          else if result.historic is "memorial"
            marker = L.marker(geo_data.coordinates.reverse(), icon: green_icon()).addTo(window.map)
          else if result.historic is "monument"
            marker = L.marker(geo_data.coordinates.reverse(), icon: yellow_icon()).addTo(window.map)
          else if result.historic is "archaeological_site"
            marker = L.marker(geo_data.coordinates.reverse(), icon: orange_icon()).addTo(window.map)
          else if result.historic is "bondary_stone"
            marker = L.marker(geo_data.coordinates.reverse(), icon: blue_icon()).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: grey_icon()).addTo(window.map)

          marker.bindPopup("<b>" + result.name + "</b>" + "</br>" + geo_data.coordinates.reverse())
          markers.push marker
          objects.push marker

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)

  $("#find_path_button").click ->
    clean_map()

    routeControl = L.Routing.control(
      waypoints: [
        L.latLng(document.getElementById("road_y1").value, document.getElementById("road_x1").value),
        L.latLng(document.getElementById("road_y2").value, document.getElementById("road_x2").value)
      ]
    ).addTo(window.map)

    route_controler = routeControl

  $("#find_paths_button").click ->
    form = $(".simple_form.find_paths_form")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        clean_map()

        console.log(results)
        objects = []

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)

          object = L.geoJSON(geo_data).bindPopup("<b>" + result.name + "</b>").addTo(window.map)

          objects.push object
          markers.push object

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)
