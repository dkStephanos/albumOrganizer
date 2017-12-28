class Artist < ApplicationRecord
    
    has_many :user_artists
    has_many :albums
    has_many :songs, through: :albums
    
    validates :name, presence: true
    validates :name, uniqueness: true
end
