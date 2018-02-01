document.addEventListener("turbolinks:load", function() {
    if($(".songs.show").length !== 0) {
        attachSongListeners();
        getIds();
    }
})


let albumId = 0;
let songIds = [];
let currentIdIndex = 0;

function attachSongListeners() {
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

function thisSong() {
    let songId = songIds[currentIdIndex];
    updateNavigationLinks(songId);
    showFavoriteLinks(songId);
    const url = "/albums/" + albumId + "/songs/" + songId + ".json";
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get(url, function(song) {
        updateAlbumCover(song);
    });
}

function getIds() {
    getAlbumId();
    const url = "/albums/" + albumId + "/songs.json";
    $.get(("/albums/" + albumId + "/songs.json"), function(songs) {
        for (let i = 0; i < songs.length; i++) {
            songIds.push(songs[i].id);
        }
        setCurrentId();
        thisSong();
    });
}

function setCurrentId() {
    let songId = parseInt($(".js-next").attr("data-id")) - 1;
    currentIdIndex = songIds.indexOf(songId);
}

function nextSong() {
    let nextId = songIds[currentIdIndex + 1];
    const url = "/albums/" + albumId + "/songs/" + nextId + ".json";
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get(url, function(song) {
        updateSongData(song, nextId);
    });
}

function lastSong() {
    let lastId = songIds[currentIdIndex - 1];
    const url = "/albums/" + albumId + "/songs/" + lastId + ".json";
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get(url, function(song) {
        updateSongData(song, lastId);
    });
}

function getAlbumId() {
    albumId = parseInt($(".js-next").attr("album-id"));
}

function updateSongData(song, newId) {
    //Sets html equal to song attributes 
    updateFields(song);
    //Saves url of album cover and converts it to 'icon'
    updateAlbumCover(song);
    //Updates options links with id of new song
    updateOptions(song);
    //Updates the favorite links
    showFavoriteLinks(song.id);
    //Updates or Removes the 'Next Song/Last Song' link depending on whether or not another song exists in the collection
    updateNavigationLinks(newId);
    //Updates currentIdIndex to get current id of song
    setCurrentId();
}

function updateNavigationLinks(newId) {
    //Checks to see if there is a following song in the array, if so, updates the 'Next Song' link appropriately, if not, removes it. 
    let nextIndex = songIds.indexOf(newId) + 1;
    let lastIndex = songIds.indexOf(newId) - 1;
    if(nextIndex < songIds.length) {
        $(".js-next").show();
        $(".js-next").attr("data-id", songIds[nextIndex]);
    } else {
        $(".js-next").hide();
    }
    if(lastIndex > -1) {
        $(".js-last").show();
        $(".js-last").attr("data-id", songIds[lastIndex]);
    } else {
        $(".js-last").hide();
    }
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
    if(image_url.includes("blank")) {
        image_url = "/assets/" + image_url;
    }
    let icon_url = image_url.replace("original", "icon");
    $("#songAlbumCover").attr("src", icon_url);
}

function updateOptions(song) {
    //Updates options links with id of new song
    //debugger;
    let editUrl = "/albums/" + albumId + "/songs/" + song["id"] + "/edit";
    let deleteUrl = "/albums/" + albumId + "/songs/" + song["id"];
    let favoriteUrl = "/albums/" + albumId + "/songs/" + song["id"] + "/favorite?type=favorite";
    let unfavoriteUrl = "/albums/" + albumId + "/songs/" + song["id"] + "/favorite?type=unfavorite";
    $("#editSong").attr("href", editUrl);
    $("#deleteSong").attr("href", deleteUrl);
    $("#favoriteSong").attr("href", favoriteUrl);
    $("#unfavoriteSong").attr("href", unfavoriteUrl);
}


function showLinks() {
    let currentId = songIds[currentIdIndex];
    //Checks if song is favorited, showing appropriate link
    showFavoriteLinks(currentId);

    //If song is the first song, hide the previous link, if its the last song, hide the next link
    if(currentIdIndex === 0) {
        $(".js-last").hide();
        $(".js-next").show();
    } 
    if(currentIdIndex === (songIds.length - 1)) {
        $(".js-last").show();
        $(".js-next").hide();
    }
}

function showFavoriteLinks(songId) {
    let isFav = false;
    $.get("/users/current.json", function(user) {
        for (let i = 0; i < user["user_favorite_songs"].length; i++) {
            if(user["user_favorite_songs"][i].song_id === songId) {
                $("#unfavoriteSong").show();
                $("#favoriteSong").hide();
                isFav = true;
                break;
            }
        }
        if(!isFav) {
        $("#unfavoriteSong").hide();
        $("#favoriteSong").show();
    }
    });
}
 