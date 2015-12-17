$(document).on('ready page:load', function () {
	var directionsDisplay = new google.maps.DirectionsRenderer();
  var directionsService = new google.maps.DirectionsService();
  var directionOn = false
  var location_json = $('#data').data('marker'); 
  var map_options = $('#data').data('map'); 
  var m_to;
  var m_from;

  // Hmmm.. Turbolink??
  document.getElementById("plan_route").disabled = true; //hmm Ask about disable	
  $("#field_to").val(" ");

  //init map
  handler = Gmaps.build('Google');
  handler.buildMap({ 
  	provider: {}, 
  	internal: {id: 'map'}},
  	function(){
      m_from = create_marker(location_json, "from");
      //set some map params 
      handler.getMap().setZoom(map_options.zoom);
      handler.getMap().setCenter(new google.maps.LatLng(map_options.c_lat, map_options.c_lng));
  });
	
	var take_position = function(){
	 	$.ajax({
	    url: "/take_position",
	    type: "GET",
	    success: function(data){
	    	handler.removeMarker(m_from)
	    	m_from = create_marker(data.marker_options, "from");
	    	handler.getMap().setCenter(new google.maps.LatLng(data.map_options.c_lat, data.map_options.c_lng));
	    }        
	  });
	}
	// setInterval(take_position, 600000);

	function set_new_place(marker, input_id){
    $.ajax({
      url: "/find_place",
      data : {
        "lat": marker.serviceObject.position.G,
        "lng": marker.serviceObject.position.K
      },
      dataType: "json",
      type: "GET",
      success: function(data){
      	$(input_id).val(data.place);
      }  
  	});
  }

	function create_marker(location_json, type = false){
	 	var marker = handler.addMarker(location_json, {draggable: true});
	 	var input_id;
	 	if (type){
	 		marker.serviceObject.setIcon({ url:'http://googlemaps.googlermania.com/img/markerA.png' });
	 		input_id = "#field_from"
	 		//  -----
	 	}
	 	else {
	 		marker.serviceObject.setIcon({url:'http://googlemaps.googlermania.com/img/markerB.png'});
	 		input_id = "#field_to"
	 		set_new_place(marker, input_id);
	 	}
	 	handler.bounds.extendWith(marker);
	 	google.maps.event.addListener(marker.serviceObject, 'dragend', function(event) {
	 		set_new_place(marker, input_id);	
	 		if (directionOn) { 
	      directionsDisplay.setDirections({routes: []});
	      calcRoute(m_from, m_to);
	      directionsDisplay.setMap(handler.getMap());
    	}
    });
	 	return marker
	}
  
  function calcRoute(m_from, m_to) {
    var origin      = new google.maps.LatLng(m_from.serviceObject.position.G, m_from.serviceObject.position.K);
    var destination = new google.maps.LatLng(m_to.serviceObject.position.G, m_to.serviceObject.position.K);
    var request = {
        origin:      origin,
        destination: destination,
        travelMode:  google.maps.TravelMode.DRIVING
    };
    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      }
    });
  }

  google.maps.event.addListener(handler.getMap(), 'click', function(event) {
    var obj = { lat: event.latLng.G, lng: event.latLng.K };
    if (m_to) {
      handler.removeMarker(m_to) //remove marker
      directionsDisplay.setDirections({routes: []}); //remove directions
    }
    m_to = create_marker(obj);
    document.getElementById("plan_route").disabled = false; 
  });

  $("#plan_route").click( function(){
  	directionOn = true;
    calcRoute(m_from, m_to);
    directionsDisplay.setMap(handler.getMap());
    directionsDisplay.setOptions({ polylineOptions: {
            strokeWeight: 6,
            strokeOpacity: 0.6,
            strokeColor:  'green' 
        }, suppressMarkers:true });
  });
});
