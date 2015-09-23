$(document).on("ready page:load", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Clicking link on admin homepage sets active nav link
  $("div#admin-home a").click(function() {
    var href = $(this).attr("href");
    var selector = "div#admin-nav a[href='" + href + "']";
    setActiveAdminNavLink(selector);
  });

  // Clicking link in admin nav changes active nav link
  $("div#admin-nav a").click(function() {
    $("div#admin-nav button.dropdown-toggle").dropdown("toggle");
    setActiveAdminNavLink(this);
  });

  // Click the previously selected page editor tab
  var selectedTab = $("input#selected_tab").val();
  $("div.page-editor ul.nav-tabs a[href='" + selectedTab + "']").click();

  // Clicking page editor tab inserts tab ID into form
  $("div.page-editor ul.nav-tabs a").click(function() {
    var selectedTab = $(this).attr("href");
    $("input#selected_tab").val(selectedTab);
  });

  // Clear external URL or page ID field when the other field changes
  $("div#content").on("change", "select#nav_link_page_id", function() {
    $("input#nav_link_external_url").val("");
  });
  $("div#content").on("change", "input#nav_link_external_url", function() {
    $("select#nav_link_page_id").val("");
  });

  // Clicking file button opens file dialog
  $("div#content").on("click", "button.file-btn", function() {
    $(this).siblings("input[type='file']").click();
  });

  // Add check mark to file button when file input changes
  $("div#content").on("change", "input[type='file']", function() {
    $(this).siblings("button.file-btn").find("i.fa-check").fadeIn(300);
  });

  // Show downloadable checkbox if audio has been chosen
  $("div#content").on("change", "input#album_track_audio", function() {
    if ($(this).val()) {
      $("div.downloadable").fadeIn(300);
    } else {
      $("div.downloadable").fadeOut(300);
    }
  });

  // Clicking checkbox toggles checked class on parent
  $("div#content").on("change", "input[type='checkbox']", function() {
    $(this).parents("div.checkbox, div.filename").toggleClass("checked");
  });

  // Clicking settings link changes active nav link
  $("div#content").on("click", "a.settings", function() {
    $("div#admin-nav a[href='/admin/site/edit']").click();
  });

  // Add spinner to submit button on click
  $("div#content").on("click", "button.submit-btn", function() {
    $(this).find("i.fa-spinner").fadeIn(300);
  });

});

$(document).on("ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Show admin nav when leaving admin homepage
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
      var reorderUrl = $(this).parent("table.sortable").data("url");
      var resourceIds = $(this).sortable("toArray");

      $.ajax({
        method: "PATCH",
        url: reorderUrl,
        data: { resource_ids: resourceIds },
        dataType: "script"
      });
    }
  });

});

function fadeOutAlerts() {
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);
}

function setActiveAdminNavLink(selector) {
  var text = $(selector).text();
  $("div#admin-nav span.active").text(text);

  $("div#admin-nav li").removeClass("hidden");
  $(selector).parent("li").addClass("hidden");
}