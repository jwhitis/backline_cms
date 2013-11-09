$(document).on("ready page:load", function(){

  // Initialize datepicker in admin form
  $("form.admin input.datepicker").datepicker({
    dateFormat: "m-d-yy"
  });

});