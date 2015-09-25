class Circle < ActiveRecord::Base
  has_many :friend_circles, dependent: :destroy
  has_many :users, through: :friend_circles
end
