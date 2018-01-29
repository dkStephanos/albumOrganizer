require 'pry'

class Song < ApplicationRecord
    
    belongs_to :genre
    belongs_to :album
    has_many :user_favorite_songs
    has_many :users, through: :user_favorite_songs
    
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

    def self.is_last?(id)
        Song.find_by(id: (id + 1)) ? false : true
    end

    def self.is_first?(id)
        Song.find_by(id: (id - 1)) ? false : true
    end
end
