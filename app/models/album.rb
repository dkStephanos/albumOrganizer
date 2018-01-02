class Album < ApplicationRecord
    
    belongs_to :artist
    has_many :songs, dependent: :destroy
    has_many :genres, through: :songs
    
    validates :name, presence: true
    validates :release_date, presence: true
    
    def user
        self.artist.user
    end
end
