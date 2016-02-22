$(document).ready(function(){
  var toggle = 0;
  $('#help_button').click(function() {
    if (toggle == 0) {
      $('#help_request').animate({
        "margin-right": "0%"
      })
      toggle = 1;
    }
    else if(toggle == 1) {
      $('#help_request').animate({
        "margin-right": "-23.4%"
      })
      toggle = 0;
    }
  });

  $('form#new_help').on('submit', function(e){
    e.preventDefault();
    form = $(this).serialize();
    $.ajax({
      type: "POST",
      url: $(this).attr('action'),
      data: form,
      dataType: "JSON"
    }).done(function(data){
      $("#new_help").find("input[type=text], textarea").val('');
      if (data.alert) {
        show_message(data.alert, 'alert');
      }else {
        show_message(data.notice);
      }
    });
  });
  window.warn_message = function(el){
    if (el.text().replace(/\s{2,}/g, '').length != 0){
      el.fadeIn(3000);
      el.delay(6000).fadeOut(3000);
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
