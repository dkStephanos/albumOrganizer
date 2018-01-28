class Genre < ApplicationRecord
    has_many :songs
    
    def albums 
        albums = []
        
        self.songs.each do |song|
            albums.push(song.album) unless albums.include?(song.album)
        end
        
        albums
    end
end
