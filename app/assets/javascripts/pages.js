$(document).on("ready page:load", function() {

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
  var action = $("ul.navbar-nav").attr("data-action");
  $("ul.navbar-nav a").each(function() {
    if ($(this).text().toLowerCase() == action) {
      $(this).addClass("active");
    }
  });
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