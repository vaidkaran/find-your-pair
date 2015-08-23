class Message < ActiveRecord::Base
  cattr_accessor :sender, :receiver

end
