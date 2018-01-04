require 'pry'

class Song < ApplicationRecord
    
    belongs_to :genre
    belongs_to :album
    
    validates :name, presence: true
    validates :length, presence: true
    
    def time
        #Convert length into minutes and seconds
        mins = self.length / 60
        secs = '%02d' % (self.length % 60)
        
        #Return the formatted song time
        "#{mins}:#{secs}"
    end
    
    def artist
        self.album.artist
    end
    
    def user
        self.artist.user
    end
    
    def genre_name=(genre)
       self.genre = Genre.find_or_create_by(name: genre) 
    end
    
    def genre_name
        if self.genre
            self.genre.name
        end
    end
end
