$(document).ready(function() {

  // Initialize color pickers
  $("div.color-field input").minicolors({ theme: "bootstrap" });

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

    $("input#design_color_scheme_attributes_background").minicolors("value", attributes.backgroundColor);
    $("input#design_color_scheme_attributes_foreground").minicolors("value", attributes.foregroundColor);
    $("input#design_color_scheme_attributes_accent").minicolors("value", attributes.accentColor);
    $("input#design_color_scheme_attributes_text").minicolors("value", attributes.textColor);
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

  // Set image fields to equal height
  if ($(window).width() >= 768) {
    $("div.design-editor ul.nav-tabs a[href='#images']").on("shown.bs.tab", function() {
      var rowCount = $("div#images div.row").length;

      for (var i = 1; i <= rowCount; i++) {
        var selector = "div#images div.row:nth-child(" + i + ") div.image-field";
        setEqualHeight(selector);
      }
    });
  }

});

function viewThemeAttributes(options) {
  var attributes = selectedThemeAttributes();
  if (!attributes) { return false };

  $("div#theme-background-color").css("background-color", attributes.backgroundColor);
  $("div#theme-foreground-color").css("background-color", attributes.foregroundColor);
  $("div#theme-accent-color").css("background-color", attributes.accentColor);
  $("div#theme-text-color").css("background-color", attributes.textColor);
  $("div#theme-display-font").text(attributes.displayFont);
  $("div#theme-body-font").text(attributes.bodyFont);

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

function setEqualHeight(selector) {
  var heightMax = 0;

  $(selector).each(function() {
    var height = $(this).height();

    if (height > heightMax) {
      heightMax = height;
    }
  });

  $(selector).height(heightMax);
}