$(document).ready(getAlbums());

function loadAlbums(albums) {
  var template = Handlebars.compile(document.getElementById("albumLi-template").innerHTML);
  var result = template(albums);
  $("#albumList")[0].innerHTML = result;
}

function getAlbums() {
	$.get("/albums.json", function(albums) {
		for (var i = 0; i < albums.length; i++) {
			albums[i].album_cover = albums[i].album_cover.replace("original", "thumb");
		}
		loadAlbums(albums);
	});
}