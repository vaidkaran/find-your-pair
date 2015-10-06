class Project < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true
  validates :app_type, presence: true
  validates :platform, presence: true
end
