module ArtistsHelper
    
    def user_artist?(artist)
        artist.user == current_user ? true : false
    end
    
    def has_albums?(artist)
        artist.albums.empty?
    end
    
    def has_genres?(artist)
        !artist.genres.empty?
    end
    
    # Only displays first link for some reason. Not used currently
    def display_links(artist)
        if artist.user == current_user
            link_to "Add Album", new_artist_album_path(@artist) 
            link_to "Edit Artist", edit_artist_path(@artist) 
            link_to "Delete Artist", artist_path(@artist), method: :delete, data: { confirm: 'Are you certain you want to delete this?' }
        end
    end
end
