$(document).ready(function () {
    attachListeners();
});

function attachListeners() {
    //Attaches listener for 'Next Song' link
    $(".js-next").on("click", function(event) {
        // On click, prevent default and pull in song id from form field
        event.preventDefault();
        nextSong();
    });
    //Attaches listener for 'Previous Song' link

}

function nextSong() {
    let nextId = parseInt($(".js-next").attr("data-id")) + 1;
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get("/songs/" + nextId + ".json", function(data) {
        updateSongData(data, nextId);
    });
}

function updateSongData(song, nextId) {
    //Sets html equal to song attributes 
    updateFields(song);
    //Saves url of album cover and converts it to 'icon'
    updateAlbumCover(song);
    //Updates options links with id of new song
    updateOptions(song);
    //Updates or Removes the 'Next Song' link depending on whether or not another song exists in the collection
    updateNextSongLink(song, nextId)   

}

function updateNextSongLink(song, nextId) {
    //Checks to see if there is a following song in the database, if so, updates the 'Next Song' link appropriately, if not, removes it. 
    $.get("/songs/" + (nextId + 1) + ".json", function(song) {
        $(".js-next").attr("data-id", song["id"]);     
    }).fail(function() {
        $(".js-next").remove();
    });
}

function updateFields(song) {
    //Sets html equal to song attributes 
    $("#songTitle")[0].innerHTML = song["name"];
    $("#songArtist")[0].innerHTML = song["artist"]["name"];
    $("#songAlbum")[0].innerHTML = song["album"]["name"];
    $("#songGenre")[0].innerHTML = song["genre"]["name"];
}

function updateAlbumCover(song) {
    //Saves url of album cover and converts it to 'icon'
    let image_url =  song["album"]["album_cover"];
    let icon_url = image_url.replace("original", "icon");
    $("#songAlbumCover").attr("src", icon_url);
}

function updateOptions(song) {
    //Updates options links with id of new song
    $("#editSong").attr("href", ("/songs/" + song["id"] + "/edit"));
    $("#deleteSong").attr("href", ("/songs/" + song["id"]));
}