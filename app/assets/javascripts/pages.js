$(document).on("ready page:load", function() {

  // Collapse navbar on page select
  $(this).on("ajaxSuccess", function() {
    $("div#my-navbar-collapse").collapse("hide");
  });

  // Swap out album cover images on hover
  $("div#content").on({
    mouseenter: function() {
      url = $(this).attr("src").replace(".jpg", "_hover.jpg")
      $(this).attr("src", url);
    },
    mouseleave: function() {
      url = $(this).attr("src").replace("_hover.jpg", ".jpg")
      $(this).attr("src", url);
    }
  }, "a.album-cover img");

  // Highlight active tab
  var path = window.location.href.split("/");
  path = path[path.length - 1];
  $("ul.navbar-nav a[href='/" + path + "']").addClass("active");
  $("ul.navbar-nav a").click(function() {
    $("ul.navbar-nav a").removeClass("active");
    $(this).addClass("active");
  });

  // Initialize FancyBox for album covers
  $("a.album-cover").fancybox({
    padding: [15, 15, 5, 15],
    wrapCSS: "album-cover-fancybox",
    helpers: {
      title: {
        type: "inside"
      }
    }
  });

});