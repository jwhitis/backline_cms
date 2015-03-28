$(document).on("ready page:load", function() {

  // Highlight active tab
  var path = window.location.pathname.split("/");
  path = path[path.length - 1];
  $("ul.navbar-nav a[href='/" + path + "']").addClass("active");
  $("ul.navbar-nav a").click(function() {
    $("ul.navbar-nav a").removeClass("active");
    $(this).addClass("active");
  });

  // Initialize Transformicons
  transformicons.add(".tcon");

  // Collapse navbar on page select
  $(this).on("ajaxSuccess", function() {
    $("div#my-navbar-collapse").collapse("hide");
    transformicons.revert(".tcon");
  });

  // Show tweet profile image on hover
  $("div#twitter-stream a.tweet").hover(function() {
    $(this).find("div.overlay").stop().fadeToggle(300);
  });

  // Initialize tooltips
  $("div#content").tooltip({
    selector: "[data-toggle='tooltip']"
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

});