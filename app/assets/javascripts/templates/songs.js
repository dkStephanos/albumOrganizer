$(document).on("ready turbolinks:load", function() {
	if($(".albums.show").length !== 0) getSongs();
});

function loadSongs(songs) {
  var template = Handlebars.compile(document.getElementById("songLi-template").innerHTML);
  var result = template(songs);
  $("#songList")[0].innerHTML = result;
}

function getSongs() {
	let albumId = parseInt($("#songList").attr("album-id"))
	$.get(albumId + ".json", function(album) {
		loadSongs(album["songs"]);
	});
}