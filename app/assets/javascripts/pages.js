$(document).on("ready page:load", function() {

  // Initialize Transformicons
  transformicons.add(".tcon");

  // Highlight active tab
  var path = window.location.pathname.split("/");
  path = path[path.length - 1];
  $("ul.navbar-nav a[href='/" + path + "']").addClass("active");
  $("ul.navbar-nav a").click(function() {
    $("ul.navbar-nav a").removeClass("active");
    $(this).addClass("active");
  });

  // Show tweet profile image on hover
  $("div#twitter-stream a.tweet").hover(function() {
    $(this).find("div.overlay").stop().fadeToggle(300);
  });

  // Show video carousel caption on hover
  $("div#content").on({
    mouseenter: toggleCaption,
    mouseleave: toggleCaption
  }, "div#video-carousel");

  function toggleCaption() {
    if ($(window).width() >= 768) {
      $("div.carousel-caption").toggle();
    }
  }

  // Initialize tooltips
  $("div#content").tooltip({
    selector: "[data-toggle='tooltip']"
  });

  // Initialize Masonry for photo gallery
  initializeMasonry();

  // Initialize Fancybox for photo gallery
  initializeFancybox();

});

$(document).on("ajaxSuccess", function() {

  // Collapse navbar on page change
  $("div#my-navbar-collapse").collapse("hide");
  transformicons.revert(".tcon");

  // Set vertical scroll position on page change
  $("body").scrollTop(130);

  // Initialize Masonry for photo gallery
  initializeMasonry();

  // Initialize Fancybox for photo gallery
  initializeFancybox();

});

function initializeMasonry() {
  $("div#photo-gallery").imagesLoaded(function() {
    $("div#photo-gallery").masonry({
      itemSelector: "a.photo",
      gutter: 15,
      isFitWidth: true
    });
  });
}

function initializeFancybox() {
  if ($(window).width() >= 768) {
    $("a.photo").fancybox(fancybox_options);
  } else {
    $("a.photo").click(function(event) {
      event.preventDefault();
    });
  }
}