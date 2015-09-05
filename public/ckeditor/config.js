// Image upload configuration based on:
// https://github.com/galetahub/ckeditor/blob/master/app/assets/javascripts/ckeditor/config.js

CKEDITOR.editorConfig = function(config) {
  config.allowedContent = true;
  config.dialog_noConfirmCancel = true;
  config.filebrowserImageUploadUrl = "/ckeditor/images";
  config.format_tags = "h1;h2;h3;p";
  config.height = 531; // 600 including toolbar and footer
  config.linkShowAdvancedTab = false;
  config.linkShowTargetTab = false;
  config.removeDialogTabs = "link:upload;image:Link;image:advanced;iframe:advanced";
  config.scayt_autoStartup = true;
  config.toolbar = [
    [ "Format" ],
    [ "Bold", "Italic", "Underline" ],
    [ "NumberedList", "BulletedList" ],
    [ "JustifyLeft", "JustifyCenter", "JustifyRight" ],
    [ "Link", "Unlink", "Anchor" ],
    [ "Image", "Iframe" ],
    [ "Source" ]
  ];

  // Rails CSRF token
  config.filebrowserParams = function() {
    var csrf_param, csrf_token;
    var params = {};

    $("meta").each(function() {
      var name = $(this).attr("name");
      var content = $(this).attr("content");

      switch (name) {
        case "csrf-token":
          csrf_token = content;
          break;
        case "csrf-param":
          csrf_param = content;
          break;
      }
    });

    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
    }

    return params;
  };

  config.appendQueryString = function(url, params) {
    var queryString = $.param(params);
    var separator = url.indexOf("?") == -1 ? "?" : "&";
    return url + separator + queryString;
  };

  // Use the "dialogDefinition" event to customize dialogs.
  CKEDITOR.on("dialogDefinition", function(event) {
    var dialogName = event.data.name;
    var dialogDefinition = event.data.definition;

    if (dialogName == "link") {
      dialogDefinition.height = 120;

      var infoTab = dialogDefinition.getContents("info");
      infoTab.remove("emailSubject");
      infoTab.remove("emailBody");
    }

    if (dialogName == "image") {
      var infoTab = dialogDefinition.getContents("info");
      infoTab.remove("ratioLock");
      infoTab.remove("txtBorder");
      infoTab.remove("txtHSpace");
      infoTab.remove("txtVSpace");

      var uploadTab = dialogDefinition.getContents("Upload");
      var fileField = uploadTab.get("upload");
      fileField.label = "Please choose an image in one of these formats: JPG, JPEG, GIF, PNG" +
                        "<br />" +
                        'Then, press the "Upload" button below.';

      var uploadButton = uploadTab.get("uploadButton");
      uploadButton.label = "Upload";

      // Integrate Rails CSRF token into image upload dialog.
      fileField.filebrowser.params = config.filebrowserParams();
      fileField.action = config.appendQueryString(fileField.action, fileField.filebrowser.params);
    }

    if (dialogName == "iframe") {
      dialogDefinition.height = 120;

      var infoTab = dialogDefinition.getContents("info");
      infoTab.remove("scrolling");
      infoTab.remove("frameborder");
      infoTab.remove("name");
      infoTab.remove("title");
      infoTab.remove("longdesc");
    }
  });
};