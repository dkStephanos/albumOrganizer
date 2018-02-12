module AlbumsHelper
    
    def user_album?(album)
        album.user == current_user ? true : false
    end
    
    def has_songs?(album)
        album.songs.empty?
    end
    
    def has_genres?(album)
        !album.genres.empty?
    end
end
