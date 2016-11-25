# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


init_map = () ->
  window.map = L.map('mapid')
  window.map.setView([51.505, -0.09], 13)
  L.tileLayer('https://api.mapbox.com/styles/v1/mapbox/streets-v10/tiles/256/{z}/{x}/{y}?access_token=pk.eyJ1IjoicmFtaW10aSIsImEiOiJjaXZyNXNvOHQwMDFzMnptbmQ1dnV0cDBtIn0.Ajsde0n4gi9sA81bnPuK1A', {
    maxZoom: 18,
    id: '256',
    accessToken: 'pk.eyJ1IjoicmFtaW10aSIsImEiOiJjaXZyNXNvOHQwMDFzMnptbmQ1dnV0cDBtIn0.Ajsde0n4gi9sA81bnPuK1A'
  }).addTo(window.map);

$(document).ready ->
  init_map()

  $("#search_submit").click ->
    form = $(".simple_form.search")

    $.ajax
      type: "GET",
      dataType: "json",
      url: form.attr("action"),
      data: form.serialize(),
      success: (results) ->
        console.log(results)

        objects = []
        for result in results
          geo_data = JSON.parse(result.st_asgeojson)

          tags = JSON.parse("{" + result.tags.replace(/\=\>/g, ":") + "}")

          console.log tags

          temp_string = ""
          for key, value of tags
            temp_string += "<strong> " + key + ": </strong>" + value + "</br>"

          objects.push L.geoJSON(geo_data).bindPopup(temp_string).addTo(window.map)

        group = new L.featureGroup(objects);

        map.fitBounds(group.getBounds());

      error: (jqXHR, textStatus, errorThrown) ->
        console.log(textStatus)


