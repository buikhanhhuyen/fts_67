// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
function remove_fields(link) {
  $(link).prev('input[type=hidden]').val('1');
  $(link).closest('#ham').hide();
  $(link).closest('#answer_fields').hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).before(content.replace(regexp, new_id));
  $('input[type="radio"]').on('click', function() {
    $('input[type="radio"]').not(this).prop('checked', false);
  })
}

document.addEventListener('turbolinks:load', function() {
  $('input[type="radio"]').on('click', function() {
    $('input[type="radio"]').not(this).prop('checked', false);
  })
})
