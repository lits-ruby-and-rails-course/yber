$(document).on('ready page:load', function (){
  //$('.delete-order').bind('ajax:success', function() { //WHY YOU DOESN'T WORK?????

  $('.delete-order').bind('click', function() {
    $(this).closest('.order-box').fadeOut();
    show_message('Order was successfully destroyed.');
  });

  //???
  $('form#new_order').on('submit', function (e) {
    e.preventDefault();
    var form   = $(e.target),
      action = form.attr('action'),
      method = form.attr('method'),
      params = form.serializeArray();
    $.ajax({
      method: method,
      url: action + '.json',
      data: params
    }).success( function(data) {
      $("#myModal").modal('hide');
      console.log(data);
      var message = "Order was created successfully.<br/> <a href='dashboard/trip/"+data.id+"' title='link to created order' alt='link to created order'> Show created order >> </a>"
      show_message(message);
    }).fail( function(data) {
      var errors = jQuery.parseJSON(data.responseText).errors
      var error_message = "ERROR: Order wasn't created successfully."
      for (var property in errors) {
        error_message += '<br/>' + property;
        var key_errors_array = errors[property]
        for (var i in key_errors_array) {
          error_message += ': ' + key_errors_array[i];
        }
      }
      $("#myModal").modal('hide');
      show_message(error_message, 'alert');
    });
  });

  function warn_message(el){
    if (el.text().replace(/\s{2,}/g, '').length != 0){
      el.fadeIn(3000);
      el.delay(6000).fadeOut(3000);
    }
  }

  function show_message(mbody, type){
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