class MessagesController < ApplicationController
  def index
  end

  def new
    require 'pry'; binding.pry
    puts "just for pry"
  end

  def create
  end
end
