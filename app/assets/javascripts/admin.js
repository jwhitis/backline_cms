$(document).on("ready page:load", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Clicking file button opens file dialog
  $("div#content").on("click", "button.file-btn", function() {
    $(this).siblings("input[type='file']").click();
  });

  // Add check mark to file button when file input changes
  $("div#content").on("change", "input[type='file']", function() {
    $(this).siblings("button.file-btn").find("i.fa-check").fadeIn(300);
  });

  // Clicking published checkbox toggles active class on parent
  $("div#content").on("change", "input.published", function() {
    $(this).parents("div.checkbox").toggleClass("active");
  });

  // Add spinner to submit button on click
  $("div#content").on("click", "button.submit-btn", function() {
    $(this).find("i.fa-spinner").fadeIn(300);
  });

});

$(document).on("ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Initialize datepickers
  $("input.datepicker").datepicker({
    dateFormat: "DD, MM d, yy"
  });

  // Initialize Fancybox for image previews
  $("a.image-preview").fancybox(fancyboxOptions);

});

function fadeOutAlerts() {
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);
}