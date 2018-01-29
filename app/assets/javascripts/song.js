$(document).ready(function () {
  $(".js-next").on("click", function(event) {
    //debugger;
    // On click, prevent default and pull in song id from form field
    event.preventDefault();
    let nextId = parseInt($(".js-next").attr("data-id")) + 1;
    //Obtain song data with jQuery call to JSON object, parsing response back into HTML fields
    $.get("/songs/" + nextId + ".json", function(data) {
        let song = data;
        $("#songTitle")[0].innerHTML = song["name"];
        $("#songArtist")[0].innerHTML = song["artist"]["name"];
        $("#songAlbum")[0].innerHTML = song["album"]["name"];
        //Saves url of album cover and converts it to 'icon'
        let image_url =  song["album"]["album_cover"];
        let icon_url = image_url.replace("original", "icon");
        $("#songAlbumCover").attr("src", icon_url);
        $("#songGenre")[0].innerHTML = song["genre"]["name"];
        //Updates options links with id of new song
        $("#editSong").attr("href", ("/songs/" + song["id"] + "/edit"));
        $("#deleteSong").attr("href", ("/songs/" + song["id"]));
        //Checks to see if there is a following song in the database, if so, updates the 'Next Song' link appropriately, if not, removes it. 
        $.get("/songs/" + (nextId + 1) + ".json", function(data) {
            $(".js-next").attr("data-id", song["id"]);     
        }).fail(function() {
            $(".js-next").remove();
        });   
    });
  });
});