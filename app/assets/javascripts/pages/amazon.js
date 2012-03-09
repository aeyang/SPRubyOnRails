$(function(){
	if($("#amazon").length != 0){
		
		$("#amazon_content_div div").hover(show, noshow);
	}
});

function show(){
	console.log($(this));
  //$(this).hide();
  $(this).children('span').show();
}

function noshow(){
	$(this).children('span').hide('fast');
  //$(this).show('fast');
}