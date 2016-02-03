# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#help_button').click ->
    $('#help_request').animate({width: 'toggle'});

  $('form#new_help').on 'submit', (e) ->
    e.preventDefault();
    valueToSubmit = $(this).serialize();
    $.ajax {
      type: "POST"
      url: $(this).attr('action')
      data: valueToSubmit
      dataType: "JSON"
    }
