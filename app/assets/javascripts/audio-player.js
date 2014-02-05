$(document).on("ready page:load", function(){

  var media = [
    "http://toddfarrell.s3.amazonaws.com/audio/Year_In_Review.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Plastic_Knives.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Bobby_And_Chipper.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Pawnshops.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Liner_Notes.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Better_Men.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/If_Its_Alright_By_You.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/Take_It_Slow.mp3",
    "http://toddfarrell.s3.amazonaws.com/audio/My_Currency_Is_Doubt.mp3"
  ]

  var currentSong = media[0];
  $("span#song-title").text(songTitle());

  // Instantiate jPlayer
  $("div#my-jplayer").jPlayer({
    ready: function () {
      $(this).jPlayer("setMedia", {
        mp3: currentSong
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
    currentSong = media[prevSongIndex()];
    changeMedia();
  });

  $("div#next").click(function(){
    currentSong = media[nextSongIndex()];
    changeMedia();
  });

  function changeMedia(){
    $("span#song-title").text(songTitle());
    $("div#my-jplayer").jPlayer("setMedia", {
      mp3: currentSong
    }).jPlayer("play");
  }

  function prevSongIndex(){
    return songIndex() == 0 ? media.length - 1 : songIndex() - 1;
  }

  function nextSongIndex(){
    return songIndex() == media.length - 1 ? 0 : songIndex() + 1;
  }

  function songIndex(){
    return media.indexOf(currentSong);
  }

  function songTitle(){
    var songTitle = currentSong.split("/");
    songTitle = songTitle[songTitle.length - 1];
    return songTitle.match(/\w*/)[0].replace(/_/g, " ");
  }

});