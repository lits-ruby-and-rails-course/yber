$(document).ready(function(){
  var toggle = 0;
  $('#help_button').click(function() {
    if (toggle == 0) {
      $('#help_request').animate({
        right: "0"
      })
      toggle = 1;
    } else  {
      $('#help_request').animate({
        right: "-300px"
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
