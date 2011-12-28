$(function () {
	if($("#lastFM").length != 0){
		$("#lastFM_upcoming_submit").click(submitHandler);
	}
});

function submitHandler(callback){

	//The > syntax means the first child that is an "input" element of the element on the left side
	var artist = $("#lastFM_upcoming_form > input").val();
	if(!artist){
	  	alert("Please Enter the name of an artist or a band...");
	}
	else{
		var getEventsURL = "http://ws.audioscrobbler.com/2.0/?method=artist.getevents&format=json&api_key=f5d61ca601bcc9956237b6377f70abf6"
		$.getJSON(getEventsURL,
		  {
		  	artist: artist,
		  	autocorrect: 1,
		  	festivalsonly: 0,
		  	dataType: "jsonp"
		  }, 
		  function (data){
		  	var list = $("#lastFM_events_list");
		  	
		  	//Emptying list
		  	if(list.children().length != 0){
		  		list.empty();
		  	}

		  	var items = [];

		  	if(data.events.event == null){
		  		console.log("no events");
		  		
		  	}
		  	else {
			  	for(var i = 0; i < data.events.event.length; i++){
			  		items.push('<li id="loom">' + data.events.event[i].title + '</li>');
			  	}
			  	
			  	list.append(items.join(' '));
			}
		  });
	}
}