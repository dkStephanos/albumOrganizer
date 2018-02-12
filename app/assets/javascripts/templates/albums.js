document.addEventListener("turbolinks:load", function() {
  if($(".albums.index").length !== 0) {
		getAlbums();
		attachAlbumListeners();
	}
})

function loadAlbums(albums) {
  var template = Handlebars.compile(document.getElementById("albumLi-template").innerHTML);
  var result = template(albums);
  $("#albumList")[0].innerHTML = result;
}

function getAlbums() {
	$.get("/albums.json", function(albums) {
		for (var i = 0; i < albums.length; i++) {
			if(albums[i].album_cover.includes("blank")) {
				albums[i].album_cover = "/assets/" + albums[i].album_cover;
			}
			albums[i].album_cover = albums[i].album_cover.replace("original", "thumb");
		}
		loadAlbums(albums);
	});
}

function attachAlbumListeners() {
	//Attaches listener for 'Add Album' link
    $("#addAlbum").on("click", function(event) {
        // On click, prevent default and show new album form/hide add album button
        event.preventDefault();
        $(".albumForm").show();
        $("#albumCoverUpload").hide();
        $("#addAlbum").hide();
    });
    $("#new_album").unbind('submit').bind('submit', function(){
    	//prevent form from submitting the default way
     	event.preventDefault();
      	let values = $(this).serialize();
      	submitNewAlbum(values);
	});
}

function submitNewAlbum(values) {
	let submitting = $.post('/albums', values);
	submitting.done( function(data) {
		getAlbums();
		$(".albumForm").hide();
        $("#addAlbum").show();
	});
}