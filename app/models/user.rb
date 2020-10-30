class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable,
        omniauth_providers: [:facebook]

  has_many :notifications, foreign_key: :recipient_id
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :profile_pic
  
  has_friendship

  after_create :send_friend_request

  #add code to send friend request from me, upon new user sign up. 
  def send_friend_request
  
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = "Facebook guest ##{rand(1..1000)}"
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0,20]
    end
  end

  

end
