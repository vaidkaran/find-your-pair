class MessagesController < ApplicationController
  def inbox
  end

  def personal_message
    @sender = current_user.id
    @receiver = params[:receiver]
    @message = Message.new
    @show_messages = true
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      #render 'welcome/lihp'
      redirect_to(action: :personal_message, receiver: message_params[:receiver])
    else
      flash.now[:alert] = "An Error occured while sending your message"
      render 'welcome/lihp'
    end
  end


  def message_params
    params.require(:message).permit(:content, :sender, :receiver)
  end
end
