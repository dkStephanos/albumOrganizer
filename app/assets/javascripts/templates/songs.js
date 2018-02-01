$(document).on("ready turbolinks:load", function() {
	if($(".albums.show").length !== 0) getSongs();
});

function Song(id, name, album_id) {
	this.id = id;
	this.name = name;
	this.album_id = album_id;
}

Song.prototype.getTime = function(length) {
	//Convert length into minutes and seconds
    let mins = Math.floor(length / 60);
    let secs = (length % 60);
    //Return the formatted song time
    this.time = `${mins}:`;
    this.time += (secs < 10 ? "0" : "");
    this.time += `${secs}`;
}

function loadSongs(songs) {
	var template = Handlebars.compile(document.getElementById("songLi-template").innerHTML);
	var result = template(songs);
	$("#songList")[0].innerHTML = result;
}

function getSongs() {
	let album_id = parseInt($("#songList").attr("album-id"))
	$.get(album_id + ".json", function(album) {
		loadSongs(createSongs(album["songs"]));
	});
}

function createSongs(json_songs) {
	var songs = json_songs.map(function (s) {
    	let song = new Song(s.id, s.name, s.album_id);
    	song.getTime(s.length);
    	return song;
  	});
	return songs;
}