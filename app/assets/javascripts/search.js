$(document).on('ready page:load', function(){
	// debugger
  $('#country').typeahead({
    name: "job",
    displayKey: 'country',
    remote: "/jobs/autocomplete?query=%QUERY"
  });

  // $('.tt-hint').addClass('form-control');


});
