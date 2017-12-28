class Song < ApplicationRecord
    
    belongs_to :album
    
    validates :name, presence: true
    validates :length, presence: true
end
