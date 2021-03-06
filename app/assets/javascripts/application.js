// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= transactions
//= require foundation
//= require_tree .
//= require underscore
//= require gmaps/google
//= require geocomplete
$(function() {
  $(document).foundation();
  
  $("#geo-input").geocomplete();
});

$('[data-dropdown-content] a').click(function() {
   var id = $(this).closest('ul').attr('id');
   $('[data-dropdown=' + id + ']').trigger('click');
});

braintree.setup("CLIENT-TOKEN-FROM-SERVER", "dropin", {
  container: "dropin-container",
  form: "checkout-form"
});

