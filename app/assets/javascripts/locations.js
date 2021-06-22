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

  var marker, i;

  for (i = 0; i < locations.length; i++) {

    // Improvement idea (to implement): add different sets of markers (different colors) according to the rounds (which means that one location could have serveral markers on it)???

    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i].dataset.lat, locations[i].dataset.lon),
      map: map
    });

    //extend the bounds to include each marker's position
    latlngbounds.extend(marker.position);

    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        var rounds = JSON.parse(locations[i].dataset.rounds);
        var days = [];
        for (n = 0; n < rounds.length; n++) {
          var round = rounds[n];
          var day = round.day;
          days.push(day);
        };
        // infowindow.setContent(locations[i].dataset.markercontent);
        infowindow.setContent(locations[i].dataset.markercontent + "<br><strong>Livraisons:</strong><br>" + days.join("<br>"));
        infowindow.open(map, marker);
      };
    })(marker, i));

    //Center map and adjust Zoom based on the position of all markers.
    map.setCenter(latlngbounds.getCenter());
    map.fitBounds(latlngbounds);
  };

};
