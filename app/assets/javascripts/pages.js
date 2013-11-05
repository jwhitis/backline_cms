$(document).on("ready page:load", function(){

  // Instantiate jPlayer
  $("div#my-jplayer").jPlayer({
    ready: function () {
      $(this).jPlayer("setMedia", {
        mp3: "http://toddfarrell.s3.amazonaws.com/audio/Plastic_Knives_Master.mp3"
      });
    },
    swfPath: "/",
    supplied: "mp3",
    cssSelectorAncestor: "div#main",
    cssSelector: {
      play: "div#play-container",
      pause: "div#pause-container"
    },
    keyEnabled: true
  });

});