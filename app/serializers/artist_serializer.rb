class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :bio, :avatar
  has_many :albums
  has_many :songs
  has_many :genres
end
