class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         
  has_many :artists
  has_many :albums, through: :artists
  has_many :songs, through: :albums
  has_many :user_favorite_songs
  has_many :favorite_songs, through: :user_favorite_songs, source: :song
  has_many :sent_access_requests, class_name: "AccessRequest", foreign_key: "requester_id"
  has_many :received_access_requests, class_name: "AccessRequest", foreign_key: "requested_id"

         
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end
end
