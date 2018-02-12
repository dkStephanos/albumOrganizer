document.addEventListener("turbolinks:load", function() {
  if($(".artists.index").length !== 0) {
		getArtists();
		attachArtistListeners();
	}
})


function loadArtists(artists) {
  var template = Handlebars.compile(document.getElementById("artistLi-template").innerHTML);
  var result = template(artists);
  $("#artistList")[0].innerHTML = result;
}

function getArtists() {
	$.get("/artists.json", function(artists) {
		for (var i = 0; i < artists.length; i++) {
			if(artists[i].avatar.includes("blank")) {
				artists[i].avatar = "/assets/" + artists[i].avatar;
			}
			artists[i].avatar = artists[i].avatar.replace("original", "thumb");
		}
		loadArtists(artists);
	});
}

function attachArtistListeners() {
	//Attaches listener for 'Add Artist' link
    $("#addArtist").on("click", function(event) {
        // On click, prevent default and show new artist form/hide add artist button
        event.preventDefault();
        $(".artistForm").show();
        $("#avatarUpload").hide();
        $("#addArtist").hide();
    });
    $("#new_artist").unbind('submit').bind('submit', function() {
    	//prevent form from submitting the default way
     	event.preventDefault();
      	let values = $(this).serialize();
      	submitNewArtist(values);
	});
}

function submitNewArtist(values) {
	let submitting = $.post('/artists', values);
	submitting.done( function(data) {
		getArtists();
		$(".artistForm").hide();
        $("#addArtist").show();
	});
}