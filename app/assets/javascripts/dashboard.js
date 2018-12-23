function initMap (lat, lng) {
  var coordinates = new google.maps.LatLng(lat, lng);
  var options = {
    zoom: 13,
    center: coordinates
  }

  var map = new google.maps.Map(document.getElementById('map'),
options);

  var marker = new google.maps.Marker({
    position: coordinates,
    map: map
  });
}
