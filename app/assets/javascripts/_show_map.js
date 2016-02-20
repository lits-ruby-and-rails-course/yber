$(document).on('ready page:load', function (){
if($('#small_map').length){
  var sgm_directionsDisplay = new google.maps.DirectionsRenderer();
  var sgm_directionsService = new google.maps.DirectionsService();
  var sgm_from_location_json = $('#small_map_data').data('m1');
  var sgm_to_location_json = $('#small_map_data').data('m2');
  var sgm_handler = Gmaps.build('Google');

  function sgm_create_route(sgm_from, sgm_to){
    sgm_calcRoute(sgm_from, sgm_to);
    sgm_directionsDisplay.setMap(sgm_handler.getMap());
    sgm_directionsDisplay.setOptions({ polylineOptions: {
      strokeWeight: 3,
      strokeOpacity: 0.6,
      strokeColor:  'green'
    }, suppressMarkers:true });
  }

  function sgm_create_marker(location_json, type){
    var marker = sgm_handler.addMarker(location_json);
    if (type){
      marker.serviceObject.setIcon({ url:'http://googlemaps.googlermania.com/img/markerA.png' });
    }
    else {
      marker.serviceObject.setIcon({url:'http://googlemaps.googlermania.com/img/markerB.png'});
    }
    sgm_handler.bounds.extendWith(marker);
    return marker;
  }

  function sgm_calcRoute(sgm_from, sgm_to) {
    var origin      = new google.maps.LatLng(sgm_from.serviceObject.position.lat(), sgm_from.serviceObject.position.lng());
    var destination = new google.maps.LatLng(sgm_to.serviceObject.position.lat(), sgm_to.serviceObject.position.lng());
    var request = {
      origin:      origin,
      destination: destination,
      travelMode:  google.maps.TravelMode.DRIVING
    };
    sgm_directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        sgm_directionsDisplay.setDirections(response);
      }
    });
  }

  //init map
  sgm_handler.buildMap({
      provider: {},
      internal: {id: 'small_map'}
    },
    function(){
      var sgm_from = sgm_create_marker(sgm_from_location_json, "from");
      var sgm_to = sgm_create_marker(sgm_to_location_json);
      sgm_create_route(sgm_from, sgm_to);
    }
  );
}
});