// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(function(){
	if($("#usershow_content_div").length != 0){
		$("#bands_following_list li img").click(clickHandler);
	}
});

function clickHandler(event){
   
   $(this).attr("id", "active");

   $(".concerts img, .albums img").stop().animate({
            'width'     :'199px',
            'height'    :'199px',
            'top'       :'-25px',
            'left'      :'-25px',
            'opacity'   :'1.0'
           },500,'easeOutBack', function(){
                    	
                $(".concerts img, .albums img").stop().animate({
                    'width'     :'52px',
                    'height'    :'52px',
                   	'top'       :'0px',
                    'left'      :'0px',
                  	'opacity'   :'0.1'
                   },500,'easeOutBack');
    });
}