$(document).on("ready page:load", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Clicking link in admin nav dropdown changes text
  $("div#admin-nav a").click(function() {
    $("div#admin-nav button.dropdown-toggle").dropdown("toggle");

    var text = $(this).text();
    $("div#admin-nav span.active").text(text);

    $("div#admin-nav a").removeClass("hidden");
    $(this).addClass("hidden");
  });

  // Clicking file button opens file dialog
  $("div#content").on("click", "button.file-btn", function() {
    $(this).siblings("input[type='file']").click();
  });

  // Add check mark to file button when file input changes
  $("div#content").on("change", "input[type='file']", function() {
    $(this).siblings("button.file-btn").find("i.fa-check").fadeIn(300);
  });

  // Clicking checkbox toggles checked class on parent
  $("div#content").on("change", "input[type='checkbox']", function() {
    $(this).parents("div.checkbox, div.filename").toggleClass("checked");
  });

  // Add spinner to submit button on click
  $("div#content").on("click", "button.submit-btn", function() {
    $(this).find("i.fa-spinner").fadeIn(300);
  });

});

$(document).on("ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Show admin nav
  $("div#admin-nav").removeClass("hidden");

  // Initialize datepickers
  $("input.datepicker").datepicker({
    dateFormat: "DD, MM d, yy"
  });

  // Initialize Fancybox for image previews
  $("a.image-preview").fancybox(fancyboxOptions);

  // Initialize sortable tables
  $("table.sortable tbody").sortable({
    items: "tr",
    axis: "y",
    containment: "table.sortable",
    stop: function() {
      var url = $(this).parent("table.sortable").data("url");
      var resourceIds = $(this).sortable("toArray");

      $.ajax({
        method: "PATCH",
        url: url,
        data: { resource_ids: resourceIds },
        dataType: "script"
      });
    }
  });

  // Clear external URL or page ID field when the other field changes
  $("select#nav_link_page_id").change(function() {
    $("input#nav_link_external_url").val("");
  });
  $("input#nav_link_external_url").change(function() {
    $("select#nav_link_page_id").val("");
  });

  // Show downloadable checkbox if audio has been chosen
  $("input#album_track_audio").on("change", function() {
    if ($(this).val()) {
      $("div.downloadable").fadeIn(300);
    } else {
      $("div.downloadable").fadeOut(300);
    }
  });

});

function fadeOutAlerts() {
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);
}