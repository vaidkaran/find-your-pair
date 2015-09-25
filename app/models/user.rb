class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :projects
  has_many :technologies
  has_many :inbox_messages

  has_many :friend_circles, dependent: :destroy
  has_many :circles, through: :friend_circles
end
