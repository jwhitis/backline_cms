$(document).ready(function() {

  // Initialize color pickers
  $("div.color-field input").minicolors({
    defaultValue: "rgba(0, 0, 0, 1)",
    format: "rgb",
    opacity: true,
    theme: "bootstrap",
    swatches: [
      "rgba(217, 94, 64, 1)",   // Red
      "rgba(242, 153, 46, 1)",  // Orange
      "rgba(86, 188, 138, 1)",  // Green
      "rgba(82, 158, 204, 1)",  // Blue
      "rgba(167, 125, 194, 1)", // Purple
      "rgba(68, 68, 68, 1)",    // Grey
      "rgba(255, 255, 255, 1)"  // White
    ]
  });

  // View attributes of selected theme
  viewThemeAttributes();

  // View sample of selected fonts
  var displayFont = $("select#design_display_font").val();
  var bodyFont = $("select#design_body_font").val();
  viewFontSamples(displayFont, bodyFont);

  // Change attributes when a new theme is selected
  $("select#design_theme").change(function() {
    viewThemeAttributes({ fontSamples: true });
  });

  // Apply attributes of selected theme to form inputs
  $("button#apply-theme").click(function() {
    var attributes = selectedThemeAttributes();

    $("input#design_color_scheme_attributes_nav_background").minicolors("value", attributes.navBackgroundColor);
    $("input#design_color_scheme_attributes_nav_text").minicolors("value", attributes.navTextColor);
    $("input#design_color_scheme_attributes_main_background").minicolors("value", attributes.mainBackgroundColor);
    $("input#design_color_scheme_attributes_main_text").minicolors("value", attributes.mainTextColor);
    $("input#design_color_scheme_attributes_footer_background").minicolors("value", attributes.footerBackgroundColor);
    $("input#design_color_scheme_attributes_footer_text").minicolors("value", attributes.footerTextColor);
    $("input#design_color_scheme_attributes_button_background").minicolors("value", attributes.buttonBackgroundColor);
    $("input#design_color_scheme_attributes_button_text").minicolors("value", attributes.buttonTextColor);
    $("select#design_display_font").val(attributes.displayFont);
    $("select#design_body_font").val(attributes.bodyFont);

    $("div#display-font-sample").css("font-family", attributes.displayFont);
    $("div#body-font-sample").css("font-family", attributes.bodyFont);
  });

  // Change sample when a new display font is selected
  $("select#design_display_font").change(function() {
    var font = $(this).val();
    $("div#display-font-sample").css("font-family", font);
  });

  // Change sample when a new body font is selected
  $("select#design_body_font").change(function() {
    var font = $(this).val();
    $("div#body-font-sample").css("font-family", font);
  });

});

function viewThemeAttributes(options) {
  var attributes = selectedThemeAttributes();
  if (!attributes) { return false };

  $("div#nav-background-color").css("background-color", attributes.navBackgroundColor);
  $("div#nav-text-color").css("background-color", attributes.navTextColor);
  $("div#main-background-color").css("background-color", attributes.mainBackgroundColor);
  $("div#main-text-color").css("background-color", attributes.mainTextColor);
  $("div#footer-background-color").css("background-color", attributes.footerBackgroundColor);
  $("div#footer-text-color").css("background-color", attributes.footerTextColor);
  $("div#button-background-color").css("background-color", attributes.buttonBackgroundColor);
  $("div#button-text-color").css("background-color", attributes.buttonTextColor);
  $("div#display-font").text(attributes.displayFont);
  $("div#body-font").text(attributes.bodyFont);

  if (options && options.fontSamples) {
    viewFontSamples(attributes.displayFont, attributes.bodyFont);
  }
}

function selectedThemeAttributes() {
  var themeTitle = $("select#design_theme").val();
  return $("option[value='" + themeTitle + "']").data();
}

function viewFontSamples(displayFont, bodyFont) {
  $("div#display-font-sample").css("font-family", displayFont);
  $("div#body-font-sample").css("font-family", bodyFont);
}