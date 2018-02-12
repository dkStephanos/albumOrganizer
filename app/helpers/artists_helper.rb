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
    
end
