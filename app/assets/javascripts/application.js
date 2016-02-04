// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= transactions
//= require foundation
//= require_tree .
//= require underscore
//= require gmaps/google
//= require geocomplete
//= require jquery.vide
$(function() {
  $(document).foundation();
  
  $("#geo-input").geocomplete();
});

$('[data-dropdown-content] a').click(function() {
   var id = $(this).closest('ul').attr('id');
   $('[data-dropdown=' + id + ']').trigger('click');
});

braintree.setup("CLIENT-TOKEN-FROM-SERVER", "dropin", {
  container: "dropin-container",
  form: "checkout-form"
});

// Lets define our options object holder
var optionsTop = {
    // String - css #id of element that needs video background 
    // if you wont to put it on <body> then you need also to assign #id like: <body id="video-background">
    elementID: "video-horizontal-top",
    // String - Center video on desired position
    align: "left",
    // String - Video css display property. Sometimes you want fixed of static?
    display: "absolute",
    // Bollean - true || false - should video be stretched with parent element?
    stretch: true,
    // Integer - original video dimensions. So we can calculate aspect ratio and some other stuff
    width: 1280,
    height: 720,
    // Boolean - autostart video on loaded event?
    autostart: false,
    // Boolean - Display html5 video controls?
    controls: false,
    // Boolean - loop video on the end all over again
    loop: true,
    // Boolean - do we need sound?
    muted: true,
    // String - local || remote - where is video hosted?
    videoLocation: "local",
    // String - path to video file without filename
    path: "video/",
    // String - filename of video without extension
    filename: "small",
    // Array - extensions of video files we have in parent folder?
    // MPEG4 for Safari
    // Ogg Theora for Firefox 3.1b2
    types: ["mp4", "ogg", "webm"],
    poster: false,
    // String - unique CSS id that we will assign to created video element
    videoID: "video_background_top",
    // Integer - video z-index value
    zIndex: "0",
    // CALLBACKS
    // Its called when video is clicked
    onclick: function(){
        // pauseVideo
        // playVideo
        // isPaused
        // isEnded

        if(this.isPaused() === true){
           this.playVideo(); 
        }else{
            this.pauseVideo();
        }

    },
    // Its called when video ended
    ended: function() {
        console.log("ended")
    },
    // Its called when video has error
    onError: function(e) {

    }
}
// Create our video and add options to it
new videoBackground(optionsTop);

