
$(document).on('ready page:load', function(){
      $("#job_type").change(function(){
        if ($(this).val() == 'WorkingHoliday' || $(this).val() =='Internship') {
          
          $('#salary').show();
          $('#name').show();
          $('#fee').hide();
        } else {
          $('#name').hide();
          $('#fee').show();
          $('#salary').hide();
          
          }
        });
    });
