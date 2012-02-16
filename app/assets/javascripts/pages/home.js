$(function() {
  if($("#home_title_h1").length != 0){
    $("#home_feed_div").hide();
    $("#home_newsfeed_button").click(function(){
      $("#home_feed_div").slideToggle('slow', function(){});
    });
  }
});

function slideNewsFeed(){
  if($("#home_feed_div").is(":hidden")){
    
  }
}
