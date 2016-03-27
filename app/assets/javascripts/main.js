$(document).on("ready page:load", function() {

  var path = window.location.pathname;

  // Initialize Transformicons
  transformicons.add(".tcon");

  // Scrolling down the page changes the navbar to a solid color
  $(window).scroll(function() {
    if ($(window).width() >= 768) {
      if ($("body").scrollTop() > 40) {
        var background = $("nav.navbar").data("solid-background");
        var boxShadow = "0 3px 8px rgba(0, 0, 0, .1)";
      } else {
        var background = $("nav.navbar").data("initial-background");
        var boxShadow = "none";
      }

      $("nav.navbar").css({ "background-color" : background, "box-shadow" : boxShadow });
    }
  });

  // Show flash modal if it exists
  $("div#flash-modal").modal("show");

  // Clicking banner link sets active nav link
  $("a#banner-link").click(function() {
    var href = $(this).attr("href");
    $("ul.navbar-nav a").removeClass("active");
    $("ul.navbar-nav a[href='" + href + "']").addClass("active");
  });

  // Links inside of page container open in a new window
  setPageLinkTarget();

  // Show album notes on hover
  $("div#content").on({
    mouseenter: toggleAlbumNotes,
    mouseleave: toggleAlbumNotes
  }, "div.cover-art");

  // Show video caption on hover
  $("div#content").on({
    mouseenter: toggleVideoCaption,
    mouseleave: toggleVideoCaption
  }, "div#video-carousel");

  // Initialize tooltips
  $("div#content").tooltip({
    selector: "[data-toggle='tooltip']"
  });

  // Initialize Masonry and Fancybox for photo gallery
  if (path == "/photos") {
    initializeMasonry();
    initializeFancybox();
  }

  // Set page height to cover viewport
  setPageHeight();

});

$(document).on("ajaxSuccess", function(event, xhr, settings) {

  var url = settings.url;

  // Collapse navbar on page change
  $("div#main-navbar-collapse").collapse("hide");
  transformicons.revert(".tcon");

  // Links inside of page container open in a new window
  setPageLinkTarget();

  // Initialize Masonry and Fancybox for photo gallery
  if (url.match(/^\/photos/)) {
    initializeMasonry();
    initializeFancybox();
  }

  // Set page height to cover viewport
  setPageHeight();

  // Scroll past banner on page change (not including pagination)
  if (!url.match(/page=\d+/)) {
    var bannerHeight = $("div#banner:visible").height();
    $("body").scrollTop(bannerHeight);
  }

});

function setPageLinkTarget() {
  $("div#page-container a").each(function() {
    var href = $(this).attr("href");

    if (href && href.match(/^http/)) {
      $(this).attr("target", "_blank");
    }
  });
}

function toggleAlbumNotes() {
  toggleElement("div.album-notes");
}

function toggleVideoCaption() {
  toggleElement("div.carousel-caption");
}

function toggleElement(selector) {
  if ($(window).width() >= 768) {
    $(selector).fadeToggle(100);
  }
}

function initializeMasonry() {
  $("div#photo-gallery").imagesLoaded(function() {
    var masonry = new Masonry("div#photo-gallery", {
      itemSelector: "a.photo",
      gutter: 15,
      isFitWidth: true
    });

    masonry.on("layoutComplete", function() {
      $("div#photo-gallery").animate({
        opacity: 1
      }, 1000);
    }).layout();
  });
}

function initializeFancybox() {
  if ($(window).width() >= 768) {
    $("a.photo").fancybox(fancyboxOptions);
  }
}

function setPageHeight() {
  var elements = ["nav.navbar", "div#banner:visible", "div#twitter-feed", "div#newsletter-signup", "footer"];
  var difference = 0;

  for (var i = 0; i < elements.length; i++) {
    difference += $(elements[i]).outerHeight(true);
  }

  var minHeight = $("body").height() - difference;
  minHeight = minHeight > 0 ? minHeight : 0;
  $("div#main").css("min-height", minHeight);
}