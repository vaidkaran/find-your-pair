class Technology < ActiveRecord::Base
  belongs_to :user

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, presence: true
end
