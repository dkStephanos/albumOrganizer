$(document).on("ready turbolinks:load", function() {
	if($(".albums.index").length !== 0) {
		getAlbums();
		attachListeners();
	}
});

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

function attachListeners() {
	//Attaches listener for 'Add Album' link
    $("#addAlbum").on("click", function(event) {
        // On click, prevent default and show new album form/hide add album button
        event.preventDefault();
        $(".albumForm").show();
        $("#addAlbum").hide();
    });
    $("#new_album").unbind('submit').bind('submit',function() {
    	//prevent form from submitting the default way
     	event.preventDefault();

      	let values = $(this).serialize();
      	submitNewAlbum(values);
	});
}

function submitNewAlbum(values) {
	let submitting = $.post('/albums', values);
	//debugger;
	submitting.done( function(data) {
		debugger;
		getAlbums();
		$(".albumForm").hide();
        $("#addAlbum").show();
	});
}