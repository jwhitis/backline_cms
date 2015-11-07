$(document).ready(function() {

  // Toggle theme icons on click
  $("div#content").on("click", "div.editor-container a.theme-toggle", function() {
    $(this).find("i.fa").toggleClass("hidden");
  });

  // Clicking full-screen icon toggles full-screen mode
  $("div#content").on("click", "div.editor-container a.full-screen-toggle", function() {
    $(this).parents("div.tab-pane").toggleClass("full-screen");
  });

});

function initializeAceEditor(editorId, initialValue, editorMode, textareaId) {
  var lightTheme = "ace/theme/github";
  var darkTheme = "ace/theme/chaos";
  var selectedTheme = $("input#editor_theme").val() || lightTheme;

  var editorOptions = {
    theme: selectedTheme,
    showInvisibles: true,
    showPrintMargin: false
  }

  var sessionOptions = {
    tabSize: 2,
    wrap: true
  }

  var editor = ace.edit(editorId);
  editor.setOptions(editorOptions);
  editor.setValue(initialValue, 1);

  var session = editor.getSession();
  session.setOptions(sessionOptions);

  var mode = "ace/mode/" + editorMode;
  session.setMode(mode);

  // Insert editor value into form on submit
  var $textarea = $("textarea#" + textareaId);

  $textarea.parents("form").submit(function() {
    var value = editor.getValue();
    $textarea.val(value);
  });

  // Clicking theme icon toggles editor theme
  $("div.editor-container a.theme-toggle").click(function() {
    var currentTheme = editor.getTheme();
    var theme = currentTheme == lightTheme ? darkTheme : lightTheme;
    editor.setTheme(theme);
    $("input#editor_theme").val(theme);
  });

  // Clicking snippet inserts content into editor
  $("div.editor-container li.snippet").click(function() {
    var snippetTarget = $(this).data("target");

    if (snippetTarget == editorId) {
      var snippetContent = $(this).data("content");
      editor.insert(snippetContent);
    }
  });
}