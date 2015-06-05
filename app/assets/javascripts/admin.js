$(document).on("ready page:load", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

});

$(document).on("ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Initialize datepickers
  $("input.datepicker").datepicker({
    dateFormat: "DD, MM d, yy"
  });

  // Clicking published checkbox toggles active class on parent
  $("div#content").off("change", "input.published"); // Unbind existing event handlers
  $("div#content").on("change", "input.published", function() {
    $(this).parents("div.checkbox").toggleClass("active");
  });

  // Initialize Fancybox for photo previews
  $("a.photo-preview").fancybox(fancyboxOptions);

});

function fadeOutAlerts() {
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);
}