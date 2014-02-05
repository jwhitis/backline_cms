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

  // Animate album covers on hover
  // $("div#content").on("mouseover", "img.album-cover-small", function() {
  //   $(this).animate({"margin-top": "5px"}, 50);
  // });
  // $("div#content").on("mouseout", "img.album-cover-small", function() {
  //   $(this).animate({"margin-top": "0px"}, 50);
  // });

});