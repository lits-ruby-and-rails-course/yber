$(document).on('ready page:load', function (){
	var directionsDisplay = new google.maps.DirectionsRenderer();
  var directionsService = new google.maps.DirectionsService();
  var directionOn = false;
  var marker_type = false;
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
	setInterval(take_position, 600000);

	function set_new_place(lat, lng, type){
    $.ajax({
      url: "/find_place",
      data : {
        "lat": lat,
        "lng": lng
      },
      dataType: "json",
      type: "GET",
      success: function(data){
        var input_id = "#field_to";
        if (type){
          input_id = "#field_from";
        }
      	$(input_id).val(data.place);
        var obj = { lat: lat, lng: lng, infowindow: data.place};
        reset_marker(obj, type);
      }  
  	});
  }

  function find_coords(place, type){
    $.ajax({
      url: "/find_coords",
      data : {
        "place": place,
      },
      dataType: "json",
      type: "GET",
      success: function(data){
        reset_marker(data.marker_options, type)
      }  
    });
  }

	function create_marker(location_json, type){
	 	var marker = handler.addMarker(location_json, {draggable: true});
	 	if (type){
	 		marker.serviceObject.setIcon({ url:'http://googlemaps.googlermania.com/img/markerA.png' });
	 	}
	 	else {
	 		marker.serviceObject.setIcon({url:'http://googlemaps.googlermania.com/img/markerB.png'});
	 	}
	 	handler.bounds.extendWith(marker);
	 	google.maps.event.addListener(marker.serviceObject, 'dragend', function(event) {     
	 		set_new_place(marker.serviceObject.position.G, marker.serviceObject.position.K, type);	
      // if (directionOn) { 
	     //  directionsDisplay.setDirections({routes: []});
	     //  calcRoute(m_from, m_to);
	     //  directionsDisplay.setMap(handler.getMap());
     	// }
    });
	 	return marker
	}

  function reset_marker(location_json, type){
    if (type){
      handler.removeMarker(m_from);
      directionsDisplay.setDirections({routes: []});
      m_from = create_marker(location_json, "from");
    } else {
      if (m_to) {
        handler.removeMarker(m_to);
        directionsDisplay.setDirections({routes: []});
      }
      m_to = create_marker(location_json);
    }
    handler.getMap().setCenter(new google.maps.LatLng(location_json.lat, location_json.lng));
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
    set_new_place(event.latLng.G, event.latLng.K, marker_type)
    if (!marker_type){
      document.getElementById("plan_route").disabled = false; 
    }
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

  $("#input-from-button").click( function(){
    var st = $(this).parent().prev().val();
    find_coords(st, true);
  });

  $("#input-to-button").click( function(){
    var st = $(this).parent().prev().val();
    find_coords(st);
  });

  //////// marker_type.. not my best solution 
  function click_shift(evt) {   
    evt = (evt) ? evt : event;   
    if(evt.shiftKey) { 
      marker_type = true;
    } else {       
      marker_type = false;
    }  
  } 
  document.onmousedown = click_shift;
});
