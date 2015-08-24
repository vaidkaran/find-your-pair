class MessagesController < ApplicationController
  def inbox
  end

  def personal_message
    @sender = params[:sender]
    @receiver = params[:receiver]
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      render 'welcome/lihp'
      #need to post
      #redirect_to(action: :inbox)
    else
      flash.now[:alert] = "An Error occured while sending your message"
      render 'welcome/lihp'
    end
  end


  def message_params
    params.require(:message).permit(:content, :sender, :receiver)
  end
end
