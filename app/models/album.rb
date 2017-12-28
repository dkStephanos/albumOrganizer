class Album < ApplicationRecord
    
    belongs_to :artist
    has_many :songs
    
    validates :name, presence: true
    validates :release_date, presence: true
end
