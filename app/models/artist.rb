class Artist < ApplicationRecord
    
    has_many :user_artists
    has_many :albums
    has_many :songs, through: :albums
end
