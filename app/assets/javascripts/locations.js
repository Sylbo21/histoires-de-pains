function initMap() {

  var locations = [
    ['<b>Rouvraie</b><br>Parc-de-la-Rouvraie 6, 1018 Lausanne', 46.531416, 6.63330418625455, 4],
    ['<b>Palézieux-Village</b><br>Ch. des Charbonneyres 1, 1607 Palézieux-Village', 46.5561119, 6.63330418625455, 5],
    ['<b>Corcelles-sur-Chavornay</b><br>Le Château 3, 1374 Corcelles-sur-Chavornay', 46.7035444, 6.599179833679428]
  /*
   * Next point on map
   *   -Notice how the last number within the brackets incrementally increases from the prior marker
   */
  ];

  var mapOptions = {
    center: new google.maps.LatLng(locations[0][1], locations[0][2]),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };

  var map = new google.maps.Map(document.getElementById('map'), mapOptions);

  var infowindow = new google.maps.InfoWindow();

  //Create LatLngBounds object.
  var latlngbounds = new google.maps.LatLngBounds();

  var marker, i;

  for (i = 0; i < locations.length; i++) {
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i][1], locations[i][2]),
      map: map
    });

    //extend the bounds to include each marker's position
    latlngbounds.extend(marker.position);

    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent(locations[i][0]);
        infowindow.open(map, marker);
      }
    })(marker, i));

    //Center map and adjust Zoom based on the position of all markers.
    map.setCenter(latlngbounds.getCenter());
    map.fitBounds(latlngbounds);
  };

};
