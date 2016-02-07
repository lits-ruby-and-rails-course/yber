$(document).on('ready page:load', function (){
if($('#map').length){
  var directionsDisplay = new google.maps.DirectionsRenderer();
  var directionsService = new google.maps.DirectionsService();
  var directionOn = false;
  var marker_type = false;
  var location_json = $('#data').data('marker');
  var map_options = $('#data').data('map');
  var m_to;
  var m_from;
  var handler = Gmaps.build('Google');

  // PRICE ------------------------------
  var distance;

  // in $ => http://lviv.best-taxi.in.ua
  var first_km_price = 0.56,
      count_of_fkm = 2,
      additional_price = 0,
      km_price = 0.13;

  function calc_price(dist, addp, cfkm, fkmp, kmp){
    var price = addp;
    dist = Math.ceil(dist / 100);
    if (dist <= cfkm){
      price += dist * fkmp;
    } else {
      price += (cfkm * fkmp) + ((dist - cfkm) * kmp)
    }
    
    return Math.round(price * 100) / 100;
  }
  //------------------------------

  $("#plan_route").disabled = true; //hmm Ask about disable
  $("#field_to").val(" ");

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

  $("#crtord_btn").click(function() {
    if(directionsDisplay.map){
      if (directionsDisplay.getDirections().routes.length > 0) {
        $("#myModal").modal('show');
        $("#mw_mfrom").val($("#field_from").val());
        $("#mw_mto").val($("#field_to").val());
        $("#mw_mfrom_lat").val(m_from.serviceObject.position.G);
        $("#mw_mfrom_lng").val(m_from.serviceObject.position.K);
        $("#mw_mto_lat").val(m_to.serviceObject.position.G);
        $("#mw_mto_lng").val(m_to.serviceObject.position.K);

        // PRICE
        var price = calc_price(distance, additional_price, count_of_fkm, first_km_price, km_price);
        $("#mw_price").val(price);
      } else {
        alert("You just change location, please push plan route again");
      }
    } else {
      alert("You must set location");
    }
  });

  $("#input-from-button").click( function(){
    var st = $(this).parent().prev().val();
    find_coords(st, true);
  });

  $("#input-to-button").click( function(){
    var st = $(this).parent().prev().val();
    find_coords(st);
  });

  function click_shift(evt) {
    evt = (evt) ? evt : event;
    if(evt.shiftKey) {
      marker_type = true;
    } else {
      marker_type = false;
    }
  }
  document.onmousedown = click_shift;

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
    return marker;
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
        distance = response.routes[0].legs[0].distance.value;
      }
    });
  }

  function take_position(){
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

  //init map  
  handler.buildMap({
    provider: {},
    internal: {id: 'map'}
  },
    function(){
      m_from = create_marker(location_json, "from");
      //set some map params
      handler.getMap().setZoom(map_options.zoom);
      handler.getMap().setCenter(new google.maps.LatLng(map_options.c_lat, map_options.c_lng));
  });

  google.maps.event.addListener(handler.getMap(), 'click', function(event) {
    set_new_place(event.latLng.G, event.latLng.K, marker_type)
    if (!marker_type){
      document.getElementById("plan_route").disabled = false;
    }
  });

  //Modal popup
  var t = false;
  $('.passengers').focus(function (){
    var $this = $(this)
    t = setInterval(
    function () {
      if (($this.val() < 1 || $this.val() > 5) && $this.val().length != 0) {
        if ($this.val() < 1) {
          $this.val(1)
        }
        if ($this.val() > 5) {
          $this.val(5)
        }
        $('p').fadeIn(1000, function () {
          $(this).fadeOut(500)
        })
      };   
    }, 50)
  })

  $('input').blur(function (){
    if (t != false) {
      window.clearInterval(t)
        t = false;
    }
  });
}
});
