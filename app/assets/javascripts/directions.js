// var directionsDisplay = new google.maps.DirectionsRenderer();
// var directionsService = new google.maps.DirectionsService();
//
// function genMap (origin, destination) {
//
//   var mapOptions = {
//     zoom: 12,
//     center: origin
//   };
//   var directions_map = new google.maps.Map(document.getElementById('directions_map'), mapOptions);
//   directionsDisplay.setMap(directions_map);
//   calculateRoute(origin, destination);
// }
//
// function calculateRoute(origin, destination) {
//   directionsService.route({
//     origin: origin,
//     destination: destination,
//     travelMode: 'DRIVING'
//   }, function (response, status) {
//     if(status === 'OK') {
//       directionsDisplay.setDirections(response);
//     } else {
//       window.alert('Directions request failed due to ' + status);
//     }
//   });
// }
