$(document).on("ready page:load", function() {

  var path = window.location.pathname;

  // Initialize Transformicons
  transformicons.add(".tcon");

  // Show flash modal if it exists
  $("div#flash-modal").modal("show");

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
  $("div#my-navbar-collapse").collapse("hide");
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
    var bannerHeight = $("a#banner").height();
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

function setPageHeight() {
  var elements = ["nav.navbar", "a#banner", "div#twitter-stream", "div#newsletter-signup", "footer"];
  var difference = 0;

  for (var i = 0; i < elements.length; i++) {
    difference += $(elements[i]).outerHeight(true);
  }

  var minHeight = $("body").height() - difference;
  minHeight = minHeight > 0 ? minHeight : 0;
  $("div#main").css("min-height", minHeight);
}