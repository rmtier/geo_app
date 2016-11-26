# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

markers = []

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
        #remove all markers
        for marker in markers
          window.map.removeLayer marker

        console.log(results)
        objects = []

        greenIcon = new L.icon ({
          iconUrl: '/assets/marker-icon-2x-green.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41] })

        greyIcon = new L.icon ({
          iconUrl: '/assets/marker-icon-2x-grey.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41] })

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)
          if result.name is null
            result.name="Unknown"
            marker = L.marker(geo_data.coordinates.reverse(), icon: greyIcon).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: greenIcon).addTo(window.map)

          marker.bindPopup(result.name)

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
        #remove all markers
        for marker in markers
          window.map.removeLayer marker

        console.log(results)
        objects = []

        greenIcon = new L.icon ({
          iconUrl: '/assets/marker-icon-2x-green.png',
          iconSize: [25, 41],
          iconAnchor: [12, 41],
          popupAnchor: [1, -34],
          shadowSize: [41, 41] })

        greyIcon = new L.icon ({
            iconUrl: '/assets/marker-icon-2x-grey.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41] })

        for result in results
          geo_data = JSON.parse(result.st_asgeojson)
          if result.name is null
            result.name="Unknown"
            marker = L.marker(geo_data.coordinates.reverse(), icon: greyIcon).addTo(window.map)
          else
            marker = L.marker(geo_data.coordinates.reverse(), icon: greenIcon).addTo(window.map)

          marker.bindPopup(result.name)
          objects.push marker

        if objects.length isnt 0
          group = new L.featureGroup(objects);
          map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)


  $("#")
