$(document).on("ready page:load", function() {

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

});