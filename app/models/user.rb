class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # association
  has_many :created_playlists, class_name: "Playlist", foreign_key: "creator_id"

  has_and_belongs_to_many :playlists, join_table: :playlists_users
end
