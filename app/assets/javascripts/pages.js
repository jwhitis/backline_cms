$(document).on("ready page:load", function(){

  // Animate navigation tabs on hover
  $("nav li").hover(function(){
    $(this).find("span").filter(":not(:animated)").animate({
      "width": "140px",
      "padding-right": "30px"
    }, 100);
  }, function(){
    $(this).find("span").animate({
      "width": "125px",
      "padding-right": "15px"
    }, 100);
  });

});