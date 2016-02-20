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
      alert(data.notice)
      $("#new_help").find("input[type=text], textarea").val('');
    }).fail(function(data){
      alert(data.notice);
    });
  });
});
