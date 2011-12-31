var globalData;
var eventOfInterest;

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
		
		//Begin JSON call. 1st parameter is base url
		$.getJSON(getEventsURL,
		  //second parameter is list of arguments
		  {
		  	artist: artist,
		  	autocorrect: 1,
		  	festivalsonly: 0,
		  	dataType: "jsonp"
		  }, 
		  //third parameter is the callback function that gets passed the json
		  function (data){
		  	globalData = data;
		  	var list = $("#lastFM_events_list");
		  	
		  	//Emptying list
		  	if(list.children().length != 0){
		  		list.empty();
		  	}

		  	var items = [];

		  	//Last.FM will pass back an array if there are multiple events. If there is only one event, it only
		  	//passes back a single object, which is frustrating because we cant just call .length on the event 
		  	//array because it might not be an array if there is only one event.Therefore, we must check the edge
		  	//case that there is only one event. 
		  	//First check if there are absolutely no events
		  	if(data.events.event == null){
		  		console.log("no events");
		  	}
		  	else {
		  		//now, check if "events" is an array. If it is it means we have more than one 
		  		//event object stored in the array.
		  		if($.isArray(data.events.event)){
				  	for(var i = 0; i < data.events.event.length; i++){
				  		//Grab picture and title of the event and push it into an array
				  		items.push('<li class="clickable">' + '<img src='  + data.events.event[i].image[2]["#text"] + ' alt="eventPic"/>' 
				  		+ data.events.event[i].title + '</li>');
				  	}
				}
				//else, we only have one event, and its an event object.
				else{
					//Grab picture and title of the event and push it into an array
					items.push('<li class="clickable">' + '<img src='  + data.events.event.image[2]["#text"] + ' alt="eventPic"/>'
					+ data.events.event.title + '</li>');
				}

				//Add all elements in list to the Events list
				list.append(items.join(' '));
			}

			//Set all <li> to be clickable and specify a click handler for all events
			$('li.clickable').css('cursor', 'pointer').click(eventClick);
		  });
	}
}

function eventClick(){
	//We do the same as above, check if there is only one event object, or an array of event objects.
	if($.isArray(globalData.events.event)){
		for(var k = 0; k < globalData.events.event.length; k++){
			var temp = globalData.events.event[k];

			if(temp.title === $(this).text()){
			   $(this).append('<ul> <li>  Starts: '  + temp.startDate +  '<br/>  Ends: ' + temp.endDate +  '</li> </ul>');
			   eventOfInterest = temp;
			   dynamicLoad();
			}
		}
	}
	else{
		if(globalData.events.event.title === $(this).text()){
			$(this).append('<ul> <li>  Starts: '  + globalData.events.event.startDate +  '<br/>  Ends: ' + 
			  globalData.events.event.endDate + '</li> </ul>');
			eventOfInterest = globalData.events.event; 
			dynamicLoad(); 
		}
	}
}

function dynamicLoad(){

	if($("#lastFM_googleMaps_script").length == 0){
		console.log("about to insert");
		$('<script>', {
			src: 'http://maps.google.com/maps/api/js?' +
			  'key=AIzaSyClnt9-I5FJqcRJK35GxFMsY-vRTc7N8N8' + '&sensor=false&callback=showMap',
			id: 'lastFM_googleMaps_script'
		}).appendTo('<body>');
	}
}

function showMap(){

	var googleLatAndLong = new google.maps.LatLng(eventOfInterest.venue.location["geo:point"]["geo:lat"],eventOfInterest.venue.location["geo:point"]["geo:long"]);

	var mapOptions = {
		zoom: 15,
		center: googleLatAndLong,
		mapTypeId: google.maps.MapTypeId.ROADMAP//This is type of map. Also try Hybrid and Satellite
	};

	map = new google.maps.Map($("#lastFM_map_div")[0], mapOptions);


	//This won't work on linux
	google.load("earth", "1", {callback: function(){alert("in");}});
}