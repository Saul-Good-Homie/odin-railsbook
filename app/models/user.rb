class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

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

  

end
