$(document).on("ready page:load", function(){

  // Initialize tooltip for password hint
  $("span#hint").tooltip({
    placement: "right"
  });

  // Initialize datepicker in admin form
  $("form.admin input.datepicker").datepicker({
    dateFormat: "m-d-yy"
  });

});