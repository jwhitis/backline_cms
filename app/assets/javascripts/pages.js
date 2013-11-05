$(document).on("ready page:load", function(){

  var media = [
    "http://toddfarrell.s3.amazonaws.com/audio/Bobby_And_Chipper.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Plastic_Knives.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Take_It_Slow.mp3"
  ]

  var currentSong = media[0];

  // Instantiate jPlayer
  $("div#my-jplayer").jPlayer({
    ready: function () {
      $(this).jPlayer("setMedia", {
        mp3: media[0]
      });
    },
    swfPath: "/",
    supplied: "mp3",
    cssSelectorAncestor: "div#main",
    cssSelector: {
      play: "div#play-container",
      pause: "div#pause-container"
    },
    preload: "auto",
    keyEnabled: true
  });

  $("div#prev").click(function(){
    $("div#my-jplayer").jPlayer("setMedia", {
      mp3: media[prevSongIndex()]
    }).jPlayer("play");
    currentSong = media[prevSongIndex()]
  });

  $("div#next").click(function(){
    $("div#my-jplayer").jPlayer("setMedia", {
      mp3: media[nextSongIndex()]
    }).jPlayer("play");
    currentSong = media[nextSongIndex()]
  });

  function prevSongIndex(){
    return songIndex() == 0 ? media.length - 1 : songIndex() - 1;
  };

  function nextSongIndex(){
    return songIndex() == media.length - 1 ? 0 : songIndex() + 1;
  };

  function songIndex(){
    return media.indexOf(currentSong);
  };

});