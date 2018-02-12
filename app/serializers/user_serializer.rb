class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_many :user_favorite_songs
end