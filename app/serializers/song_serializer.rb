class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :time, :album_id
  belongs_to :album
  belongs_to :artist
  has_one :genre
end
