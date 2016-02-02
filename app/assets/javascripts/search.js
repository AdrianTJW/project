$(document).ready(function(){
	// debugger
  $('#listing-search').typeahead({
    name: "job",
    displayKey: 'country',
    remote: "/jobs/autocomplete?query=%QUERY"
  });

  $('.tt-hint').addClass('form-control');


});
