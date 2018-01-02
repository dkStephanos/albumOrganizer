module SongsHelper
    def user_song?(song)
        song.user == current_user ? true : false
    end
end
