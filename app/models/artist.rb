class Artist < ApplicationRecord
    
    belongs_to :user
    has_many :albums, dependent: :destroy
    has_many :songs, through: :albums
    has_many :genres, -> { distinct }, through: :songs
    
    accepts_nested_attributes_for :albums
    
    validates :name, presence: true
    validates :name, uniqueness: true

    has_attached_file :avatar, default_url: ':style/blank-avatar.png', 
    styles: { thumb: "100x100#", icon: "250x250>" },
	default_url: "assets/:style/blank-avatar.png"

    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
end
