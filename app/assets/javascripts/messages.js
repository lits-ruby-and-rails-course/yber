$(document).on('ready page:load', function (){
	$("#edit-message").on('click', function(){
		var text = $("span#message-text-field").text();
		$("span#message-text-field").replaceWith('<div class="input-group">' +
      	'<input id="new-message-field" type="text" class="form-control" value="'+text+'"><span class="input-group-btn">' +
        '<button id="confirm-message-changes" class="btn btn-secondary" type="button">Ok</button></span></div>'
      );
		$("#confirm-message-changes").on('click', function(){
			var m_id = $("span#message-id").text();
			var new_text = $("#new-message-field").val();
			console.log(new_text);
			$.ajax({
	      url: "/messages/"+m_id,
	      data : {
	        "new_text": new_text,
	      },
	      dataType: "json",
	      type: "PUT",
	      success: function(data){
	        $("#new-message-field").closest('div.input-group').replaceWith('<span id="message-text-field">'+new_text+'</span>');
	      }
	    });
		});
	});
});