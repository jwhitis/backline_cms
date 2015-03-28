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
    if ($(window).width() > 767) {
      $("div.carousel-caption").toggle();
    }
  }

  // Initialize tooltips
  $("div#content").tooltip({
    selector: "[data-toggle='tooltip']"
  });

});

$(document).on("ajaxSuccess", function() {

  // Collapse navbar on page change
  $("div#my-navbar-collapse").collapse("hide");
  transformicons.revert(".tcon");

  // Set vertical scroll position on page change
  $("body").scrollTop(130);

});