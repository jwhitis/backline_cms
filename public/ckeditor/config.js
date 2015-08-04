CKEDITOR.editorConfig = function(config) {
  config.allowedContent = true;
  config.dialog_noConfirmCancel = true;
  config.format_tags = "h1;h2;h3;p";
  config.height = 400;
  config.linkShowAdvancedTab = false;
  config.linkShowTargetTab = false;
  config.scayt_autoStartup = true;
  config.toolbar = [
    [ "Format" ],
    [ "Bold", "Italic", "Underline" ],
    [ "NumberedList", "BulletedList" ],
    [ "Link", "Unlink", "Anchor" ],
    [ "Source" ]
  ];
};

// Use the "dialogDefinition" event to customize dialogs.
CKEDITOR.on("dialogDefinition", function(event) {
  var dialogName = event.data.name;
  var dialogDefinition = event.data.definition;

  if (dialogName == "link") {
    dialogDefinition.height = 120;

    // Remove unwanted fields from info tab.
    var infoTab = dialogDefinition.getContents("info");
    infoTab.remove("emailSubject");
    infoTab.remove("emailBody");
  }
});