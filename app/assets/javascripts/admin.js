$(document).on("ready page:load", function(){

  // Fade out alerts after 3 seconds
  window.setTimeout(function() {
    $("div.timer.fade").alert("close");
  }, 3000);

  // Initialize tooltips for edit icons
  $("div#content").tooltip({
    selector: "td.edit a"
  });

  // Show edit icons on table row hover
  $("div#content").on({
    mouseenter: function(){
      $(this).find("td.edit a").show();
    },
    mouseleave: function(){
      $(this).find("td.edit a").hide();
    }
  }, "div#admin tr");

  // Initialize tooltip for password hint
  $("span#hint").tooltip({
    placement: "right"
  });

  // Initialize datepicker in admin form
  $("form.admin input.datepicker").datepicker({
    dateFormat: "m-d-yy"
  });

});