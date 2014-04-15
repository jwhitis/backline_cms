$(document).on("ready page:load ajaxSuccess", function() {

  // Fade out alerts after 3 seconds
  window.setTimeout(function() {
    $("div.timer.fade").alert("close");
  }, 3000);

  // Initialize datepicker for admin form
  $("div#admin input.datepicker").datepicker({
    dateFormat: "m-d-yy"
  });

});

$(document).on("ready page:load", function() {

  // Toggle published checkbox on click
  $("div#content").on("click", "div.published-toggle", function() {
    var checkbox = $("input#show_published");
    checkbox.prop("checked", !checkbox.prop("checked"));
    $(this).toggleClass("on off");
  });

  // Initialize tooltips for edit icons
  $("div#content").tooltip({
    selector: "td.edit a"
  });

  // Show edit icons on table row hover
  $("div#content").on({
    mouseenter: function() {
      if ($(window).width() > 768) {
        $(this).find("td.edit a").show();
      }
    },
    mouseleave: function() {
      if ($(window).width() > 768) {
        $(this).find("td.edit a").hide();
      }
    }
  }, "div#admin tr");

  // Initialize tooltip for password hint
  $("span#hint").tooltip({
    placement: "right"
  });

});