$(document).ready(function(){
  var contentToggle = 0;
  $('#help_request').on('click', function(){
    if(contentToggle == 0){
      $('#help_request').animate({
        width: "300px"
      })
      contentToggle = 1;
    }
    else if (contentToggle == 1){
      $('#help_request').animate({
        width: "0px"
      })
      contentToggle = 0;
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
      alert(data.notice);
    }).fail(function(data){
      alert(data.notice);
    });
  });
});
