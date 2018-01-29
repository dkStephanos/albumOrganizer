$(document).ready(function () {
    attachListeners();
});

let albumId = 0;

function attachListeners() {
    //Attaches listener for 'Next Song' link
    $(".js-next").on("click", function(event) {
        // On click, prevent default and pull in song id from form field
        event.preventDefault();
        nextSong();
    });
    //Attaches listener for 'Last Song' link
    $(".js-last").on("click", function(event) {
        // On click, prevent default and pull in song id from form field
        event.preventDefault();
        lastSong();
    });
}

function nextSong() {
    getAlbumId();
    let nextId = parseInt($(".js-next").attr("data-id")) + 1;
    const url = "/albums/" + albumId + "/songs/" + nextId + ".json";
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get(url, function(song) {
        updateSongData(song, nextId, "next");
    });
}

function lastSong() {
    getAlbumId();
    let lastId = parseInt($(".js-last").attr("data-id")) - 1;
    const url = "/albums/" + albumId + "/songs/" + lastId + ".json";
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get(url, function(song) {
        updateSongData(song, lastId, "last");
    });
}

function getAlbumId() {
    albumId = parseInt($(".js-next").attr("album-id"));
}

function updateSongData(song, newId, type) {
    //Sets html equal to song attributes 
    updateFields(song);
    //Saves url of album cover and converts it to 'icon'
    updateAlbumCover(song);
    //Updates options links with id of new song
    updateOptions(song);
    //Updates or Removes the 'Next Song/Last Song' link depending on whether or not another song exists in the collection
    if(type === "next") {
        updateNextSongLink(song, newId)  
    } else {
        updateLastSongLink(song, newId)
    }
}

function updateNextSongLink(song, newId) {
    //Checks to see if there is a following song in the database, if so, updates the 'Next Song' link appropriately, if not, removes it. 
    const url = "/albums/" + albumId + "/songs/" + (newId + 1) + ".json";
    $.get(url, function() {
        $(".js-next").attr("data-id", song["id"]);
        $(".js-next").attr("album-id", song["album"]["id"]);       
    }).fail(function() {
        $(".js-next").hide();
    });
    //Regardless, update the 'Last Song' link and make sure it is visible
    $(".js-last").show();
    $(".js-last").attr("data-id", song["id"]); 
    $(".js-last").attr("album-id", song["album"]["id"]);  
}

function updateLastSongLink(song, newId) {
    //Checks to see if there is a preceeding song in the database, if so, updates the 'Last Song' link appropriately, if not, removes it. 
    const url = "/albums/" + albumId + "/songs/" + (newId - 1) + ".json";
    $.get(url, function() {
        $(".js-last").attr("data-id", song["id"]);
        $(".js-last").attr("album-id", song["album"]["id"]);      
    }).fail(function() {
        $(".js-last").hide();
    });
    //Regardless, update the 'Next Song' link and make sure it is visible 
    $(".js-next").show();
    $(".js-next").attr("data-id", song["id"]);
    $(".js-next").attr("album-id", song["album"]["id"]);   
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
    //debugger;
    let editUrl = "/albums/" + albumId + "/songs/" + song["id"] + "/edit";
    let deleteUrl = "/albums/" + albumId + "/songs/" + song["id"];
    $("#editSong").attr("href", editUrl);
    $("#deleteSong").attr("href", deleteUrl);
}