$(document).on('ready page:load', function(){
  $('#take_order').on('click', function (e){
    e.preventDefault();
    if (!confirm("Are you sure?")) return 0;
    var id = $('#hidden_order_id').text(),
        that = this;
    $.ajax({
      url: "/take_order/"+id,
      type: "GET",
      success: function(data){
        $('.show-order-title').html('<div><h3>Order in progress</h3></div>');
        $(that).replaceWith('<div class="order-box-driver-info padd-top">'+
          '<span class="order-field-title">Driver:<a class="little_padding" href="#" > '+data.name+'</a></span>'+
          '<ul><li>email:<span class="little_padding">'+data.email+'</span></li>'+
          '<li>phone number:<span class="little_padding">'+data.phone+'</span></li>'+
          '<li>license_plate:<span class="little_padding">'+data.license_plate+'</span></li></ul>'+
          '<div class="col-md-12 tright">accepted at:<span class="little_padding">'+data.date+' </span></div></div>');
        change_status($('div.yellow-line'), 1);
        $('#sidebar-empty-current-order').replaceWith('<div id="sidebar-current-order"><div class="row">'+
          '<div class="col-md-3 col-sm-4 col-xs-12 head">STATUS:</div><div class="col-md-9 col-sm-8 col-xs-12">accepted</div></div>'+
          '<div class="row"><div class="col-md-3 col-sm-4 col-xs-12 head">FROM:</div><div class="col-md-9 col-sm-8 col-xs-12">'+$('#order-field-mfrom').text()+'</div></div>'+
          '<div class="row"><div class="col-md-3 col-sm-4 col-xs-12 head">TO:</div><div class="col-md-9 col-sm-8 col-xs-12">'+$('#order-field-mto').text()+'</div></div>'+
          '<div class="row"><div class="col-md-12 col-sm-12 col-xs-12"><span class="head">ADDITIONAL INFORMATION:</span><span class="little_padding">'+$('#order-field-description').text()+'</span></div>'+
          '<div class="row"><div class="col-md-12 col-sm-12 col-xs-12 tright"><a href="#">more..</a></div></div>'
          );
      }
    });
  });

  $('#edit-profile').on('click', function (e){
    e.preventDefault();
    var that = this;
    if ($(that).has('i.fa-pencil-square-o').length) {
      $(that).find('i').removeClass('fa-pencil-square-o').addClass('fa-floppy-o');
      $(that).find('i').text('Update profile');
      $('.value-data').each(function (e){
        var text = $(this).text().trim();
        $(this).replaceWith('<div class="col-md-7"><input class="form-control input-data" value="' + text + '"></div>');
      });
    } else {
      var input_array = $('.profile-box').find('.input-data'),
          city = input_array[0].value,
          phone = input_array[1].value,
          license_plate = input_array[2] ? input_array[2].value : undefined,
          id = $('#hidden_profile_id').text();
      $.ajax({
        url: '/profiles/' + id + '.json',
        data : {
          "city": city,
          "car_phone": license_plate,
          "phone": phone
        },
        method: "PATCH"
      }).done(function(data){
        $(that).find('i').addClass('fa-pencil-square-o').removeClass('fa-floppy-o');
        $(that).find('i').text('Edit Profile');
        var updated_input_array = $('.profile-box').find('.input-data'),
            text;
        $(updated_input_array).each(function(index){
          text = $(this).val();
          $(this).replaceWith('<div class="col-md-7 value-data">' + text + '</div>');
        });

      }).fail(function(errorThrown){
        console.log(errorThrown);
      })
    }
  });

  $('#edit-review').on('click', function (e){
    e.preventDefault();
    var that = this,
        id = $('#hidden_review_id').text(),
        text;
    if ($(that).has('i.fa-pencil-square-o').length) {
      $(that).find('i').removeClass('fa-pencil-square-o').addClass('fa-floppy-o');
      $(that).find('i').text('Update review');
      text = $('#review-text').text().trim(),
      $('#review-text').replaceWith('<textarea class="form-control input-data">' + text + '</textarea>');
    } else {
      $.ajax({
            url    : '/reviews/' + id + '.json',
            data   : {"text": text},
            method : 'PATCH'
      }).done(function(data){
        text = $('.review-box').find('.input-data').val();
        $('.review-box').find('i').addClass('fa-pencil-square-o').removeClass('fa-floppy-o');
        $('.review-box').find('i').text('Edit Review');
        $('.review-box').find('.input-data').replaceWith('<p#review-text">' + text + '</p>');
      }).fail(function(errorThrown){
        console.log(errorThrown);
      })
    }
  });

  $('#complete_order').on('click', function (e){
    e.preventDefault();
    // if (!confirm("Are you sure?")) return 0;
    var id = $('#hidden_order_id').text(),
        that = this,
        form = $(this).closest('form');
    $.ajax({
      url: "/complete_order/"+id,
      type: "GET",
      success: function(data){
        if ( $('#reviewModal').length != 0 ) {
          change_status($('div.green-line'), 2);
          $('#updated_date span:first-child').text('complited');
          $('.show-order-title').remove();
          $('#sidebar-current-order').replaceWith('<div id="sidebar-empty-current-order"><h4>No order in progress</h4></div>');
          $('#updated_date span:last-child').text(data.date);
          $('#reviewModal').modal('hide');
          show_message(data.notice);
          $(that).remove();
        } else {
          show_message('Thank You for sharing Your oppinion!');
          window.location.reload();
        }
        create_review(form);
      }
    });
  });

  $('#cmplord_btn').on('click', function (e){
    $('#reviewModal').modal('show');
  });

  $('a.delete-order[data-remote]').on("ajax:success", function(e, data, status, xhr){
    $('#sidebar-current-order').replaceWith('<div id="sidebar-empty-current-order"><h4>No one order in progress</h4></div>');
    show_message('Order was successfully destroyed.');
    if ($('.order-box').length == 1){
      $('.order-box').parent().html('<div class="warn-tittle-box"><h3>Sorry but you have noone order</h3>'+
        '<h4>You can create new order for this link <a href="/dashboard"> create order >></a></h4></div>');
    } else {
      $(this).closest('.order-box').fadeOut();
    }
  });

  function create_review(el){
    var form   = el,
        action = form.attr('action'),
        method = form.attr('method'),
        params = form.serializeArray();
    //     stars_value = $('#count').html();
    // $('#review_stars').val(stars_value);
    $.ajax({
      method: method,
      url: action + '.json',
      data: params
    }).success( function(data) {
    }).fail( function(data) {
    });
  }

  function change_status(el, new_status){
    el.removeAttr("class");
    switch (new_status) {
      case 0:  //pending
        el.addClass('col-md-4 col-sm-6 col-xs-6 status yellow-line');
        el.text('pending');
        break;
      case 1:  //accepted
        el.addClass('col-md-4 col-sm-6 col-xs-6 status green-line');
        el.text('accepted');
        break;
      case 2:  //complited
        el.addClass('col-md-4 col-sm-6 col-xs-6 status grey-line');
        el.text('complited');
        break;
      default:
        console.log('ERROR: parameters are not correct');
    }
  }

  window.warn_message = function(el){
    if (el.text().replace(/\s{2,}/g, '').length != 0){
      el.fadeIn(3000).delay(3000).fadeOut(3000);
    }
  }

  window.show_message = function(mbody, type){
    if (type){
      var el = $('.alert');
    } else {
      var el = $('.notice');
    }
    el.empty();
    el.append(mbody);
    warn_message(el);
  }

  warn_message($('.notice'));
  warn_message($('.alert'));
});