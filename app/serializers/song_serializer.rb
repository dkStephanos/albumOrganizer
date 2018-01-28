class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :length
end
