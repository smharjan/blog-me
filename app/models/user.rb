class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :blogs, dependent: :destroy

  has_one_attached :avatar
  
  has_many :likes, dependent: :destroy

  has_many :comments, as: :commentable, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, presence: true
end
