module SongsHelper
    def user_song?(song)
        song.user == current_user ? true : false
    end
    
    def favorited(song)
        song.is_favorite.to_s.capitalize
    end
end
