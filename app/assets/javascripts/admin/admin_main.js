$(document).on("ready page:load", function() {

  var path = window.location.pathname;

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Set active admin nav link for custom pages
  if (path.match(/^\/admin\/custom_pages/)) {
    setActiveAdminNavLink("/admin/pages");
  }

  // Clicking link in admin nav changes active nav link
  $("div.admin-nav a").click(function() {
    var container = $(this).parents("div.admin-nav");

    if (container.is("div#admin-dropdown")) {
      container.find("button.dropdown-toggle").dropdown("toggle");
    }

    var href = $(this).attr("href");
    setActiveAdminNavLink(href);
  });

  // Restore the previously selected editor tab
  restoreSelectedEditorTab();

  // Clicking editor tab inserts tab ID into form
  $("div#content").on("click", "div.editor-container ul.nav-tabs a", function() {
    var selectedTab = $(this).attr("href");
    $("input#selected_tab").val(selectedTab);
  });

  // Clicking heading in snippets list expands collapsed snippets
  $("div#content").on("click", "div.editor-container div.snippets h3", function() {
    if ($(window).width() < 1200) {
      $(this).find("i.fa").toggleClass("hidden");
      $(this).next("ul").stop().slideToggle();
    }
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
    $(this).parents("div.checkbox, div.file-box").toggleClass("checked");
  });

  // Initialize checkbox switches
  initializeSwitchery();

  // Clicking settings link changes active nav link
  $("div#content").on("click", "a.settings", function() {
    $("div#admin-dropdown a[href='/admin/site/edit']").click();
  });

  // Add spinner to submit button on click
  $("div#content").on("click", "button.submit-btn", function() {
    $(this).find("i.fa-spinner").fadeIn(300);
  });

});

$(document).on("ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  fadeOutAlerts();

  // Show admin nav elements when leaving admin home page
  $("div.admin-nav").removeClass("hidden");

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

  // Initialize Fancybox for image previews
  $("a.image-preview").fancybox(fancyboxOptions);

  // Restore the previously selected editor tab
  restoreSelectedEditorTab();

  // Initialize checkbox switches
  initializeSwitchery();

  // Initialize datepickers
  $("input.datepicker").datepicker({
    dateFormat: "DD, MM d, yy"
  });

  // Set panel elements to equal height
  if ($(window).width() >= 768) {
    setEqualHeight("div.image-panel .equal-height");
    setEqualHeight("div.video-panel .equal-height");
  }

});

function fadeOutAlerts() {
  window.setTimeout(function() {
    $("div.alert.timer").alert("close");
  }, 3000);
}

function setActiveAdminNavLink(href) {
  var selector = "a[href='" + href + "']";

  var text = $("div#admin-dropdown").find(selector).text();
  $("div#admin-dropdown span.active").text(text);

  $("div#admin-dropdown li").removeClass("hidden");
  $("div#admin-dropdown").find(selector).parent("li").addClass("hidden");

  $("div#admin-sidebar a").removeClass("active");
  $("div#admin-sidebar").find(selector).addClass("active");
}

function restoreSelectedEditorTab() {
  var selectedTab = $("input#selected_tab").val();
  $("div.editor-container ul.nav-tabs a[href='" + selectedTab + "']").click();
}

function initializeSwitchery() {
  $("input.switch").each(function() {
    new Switchery(this, {
      color: "#44B359",
      secondaryColor: "#CCCCCC",
      speed: ".3s",
      size: "small"
    });
  });
}

function setEqualHeight(selector) {
  $(selector).imagesLoaded(function() {
    var heightMax = 0;

    $(selector).each(function() {
      var height = $(this).outerHeight();

      if (height > heightMax) {
        heightMax = height;
      }
    });

    $(selector).outerHeight(heightMax);
  });
}