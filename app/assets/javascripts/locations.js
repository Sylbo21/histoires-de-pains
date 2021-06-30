function initMap() {

  var locations = document.querySelectorAll('#locations-list li');

  var mapOptions = {
    center: new google.maps.LatLng(0, 0),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  var infowindow = new google.maps.InfoWindow();

  //Create LatLngBounds object.
  var latlngbounds = new google.maps.LatLngBounds();

  var marker;
  var i;

  function setMarkers(map) {

    for (i = 0; i < locations.length; i++) {

      marker = new google.maps.Marker({
        position: new google.maps.LatLng(locations[i].dataset.lat, locations[i].dataset.lon),
        map: map,
      });

      //extend the bounds to include each marker's position
      latlngbounds.extend(marker.position);

      function displayInfoWindow(marker, i) {
        return function() {
          map.setZoom(13);
          map.panTo(marker.getPosition());
          var rounds = JSON.parse(locations[i].dataset.rounds);
          var days = [];
          for (n = 0; n < rounds.length; n++) {
            var round = rounds[n];
            var day = round.day;
            days.push(day);
          };
          infowindow.setContent(locations[i].dataset.markercontent + "<br><strong>Livraisons:</strong><br>" + days.join("<br>"));
          infowindow.open(map, marker);
        };
      };

      google.maps.event.addListener(marker, 'click', (displayInfoWindow(marker, i)));

      let locationItem = document.querySelector('#location' + (i+1).toString());
      locationItem.addEventListener('click', (displayInfoWindow(marker, i)));
    };
  };

  setMarkers(map);
  //Center map and adjust Zoom based on the position of all markers.
  map.setCenter(latlngbounds.getCenter());
  map.fitBounds(latlngbounds);

};
