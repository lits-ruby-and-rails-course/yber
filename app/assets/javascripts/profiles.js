/*
 Place all the behaviors and hooks related to the matching controller here.
 All this logic will automatically be available in application.js.
 You can use CoffeeScript in this file: http://coffeescript.org/
*/

(function($) {
  $.fn.render_form_errors = function(model, errors) {
    var $form;
    $form = this;
    this.clear_previous_errors();
    $.each(errors, function(field, messages) {
      var $input;
      field = field.split('.');
      if (field.length > 1) {
        field[0] = field[0] + '_attributes';
      }
      field = '[' + field.join('][') +']';
      $input = $('[name="' + model + field + '"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html(messages.join(', '));
    });
  };
  $.fn.clear_previous_errors = function() {
    $('.form-group.has-error', this).each(function() {
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    });
  };
})(jQuery);

var show_form_errors = function (e) {
    e.preventDefault();

    var form = $(e.target),
        action = form.attr('action'),
        method = form.attr('method'),
        params = form.serializeArray();

    $.ajax({
      method: method,
      url: action + '.json',
      data: params
    }).done( function() {
      if (e.target.id == 'sign_in') {
        sign_in_errors(role, profile.role);
      }
      else {
        window.location.href = ('/dashboard');
      }
    }).fail( function(errors) {
      form.render_form_errors('user', $.parseJSON(errors.responseText).errors);
    })
  };

var sign_in_errors = function(role, profile.role) {
  if (role == 'admin') {
    window.location.href = ('/admin');
  }
  else {
    if (profile.role == "rider") {
      window.location.href = ('/dashboard');
    }
    else {
      window.location.href = ('/dashboard');
    }
  }
};

var clear_form_errors = function (e) {
  var forms = document.getElementsByClassName("registration_forms");
  console.log(forms);
  forms.each(clear_previous_errors);
};

$(document).ready( function () {
  // $('#sign_up_driver').on('hide.bs.modal', clear_form_errors);
  // $('#sign_up_rider').on('hide.bs.modal', clear_form_errors);
  $('form#new_driver').on('submit', show_form_errors);
  $('form#new_rider').on('submit', show_form_errors);
  $('form#sign_in').on('submit', sign_in_errors);
});