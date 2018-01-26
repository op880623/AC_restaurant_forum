class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader
  has_many :comments, dependent: :destroy
  has_many :restaurants, through: :comments

  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant

  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  has_many :follows, class_name: :Followship, dependent: :destroy
  has_many :followings, through: :follows

  has_many :followeds, class_name: :Followship, foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :followeds

  def admin?
    return self.role == "admin"
  end

  def following?(user)
    self.followings.include?(user)
  end

end
