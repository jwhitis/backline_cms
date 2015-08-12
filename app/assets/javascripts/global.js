$(document).on("ready page:load", function() {

  var path = window.location.pathname;

  // Initialize Transformicons
  transformicons.add(".tcon");

  // Show flash modal on non-admin pages
  if (!path.match(/^\/admin/)) {
    $("div#flash-modal").modal("show");
  }

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

});

$(document).on("ajaxSuccess", function(event, xhr, settings) {

  var url = settings.url;

  // Collapse navbar on page change
  $("div#my-navbar-collapse").collapse("hide");
  transformicons.revert(".tcon");

  // Set vertical scroll position on page change (not including pagination)
  if (!url.match(/page=\d+/)) {
    $("body").scrollTop(315);
  }

  // Links inside of page container open in a new window
  setPageLinkTarget();

  // Initialize Masonry and Fancybox for photo gallery
  if (url.match(/^\/photos/)) {
    initializeMasonry();
    initializeFancybox();
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
  // Change main background to solid color so background image
  // doesn't change size when Masonry is initialized
  $("div#main").css("background", "#152A35");

  $("div#photo-gallery").imagesLoaded(function() {
    var msnry = new Masonry("div#photo-gallery", {
      itemSelector: "a.photo",
      gutter: 15,
      isFitWidth: true
    });

    msnry.on("layoutComplete", function() {
      // Change main background back to background image
      $("div#main").css({
        background: "linear-gradient(to right, rgba(8, 50, 73, .5) 0%, rgba(8, 50, 73, .5) 100%), url(http://toddfarrell-production.s3.amazonaws.com/images/night_sky_bw.jpeg)",
        backgroundRepeat: "no-repeat",
        backgroundSize: "cover",
        backgroundPosition: "center bottom"
      });

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