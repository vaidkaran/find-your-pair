class Circle < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :motive, presence: true

  has_many :friend_circles, dependent: :destroy
  has_many :users, through: :friend_circles
end
