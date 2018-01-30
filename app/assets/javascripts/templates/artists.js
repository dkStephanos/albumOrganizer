$(document).on("ready turbolinks:load", function() {
	if($(".artists.index").length !== 0) getArtists();
});

function loadArtists(artists) {
  var template = Handlebars.compile(document.getElementById("artistLi-template").innerHTML);
  var result = template(artists);
  $("#artistList")[0].innerHTML = result;
}

function getArtists() {
	$.get("/artists.json", function(artists) {
		for (var i = 0; i < artists.length; i++) {
			artists[i].avatar = artists[i].avatar.replace("original", "thumb");
		}
		loadArtists(artists);
	});
}