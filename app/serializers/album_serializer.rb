class AlbumSerializer < ActiveModel::Serializer
  attributes :id, :name, :release_date, :album_cover
  belongs_to :artist
  has_many :songs
  has_many :genres
end
