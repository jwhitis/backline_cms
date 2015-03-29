$(document).on("ready page:load ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);

});

$(document).on("ajaxSuccess", function() {

  // Initialize datepickers
  $("input.datepicker").datepicker({
    dateFormat: "DD, MM d, yy"
  });

  // Clicking published checkbox toggles published class on parent
  $("div#content").on("change", "input.published", function() {
    $(this).parents("div.checkbox").toggleClass("published");
  });

});