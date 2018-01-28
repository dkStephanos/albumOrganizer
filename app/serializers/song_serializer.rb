class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :length
  belongs_to :album
  belongs_to :artist
  has_one :genre
end
