class MessagesController < ApplicationController
  def inbox
  end

  def personal_message
    @sender = current_user.id
    @receiver = personal_message_params[:receiver]
    @message = Message.new
    @message_thread = Message.all.where("sender=#{@sender} OR sender=#{@receiver}").where("receiver=#{@sender} OR receiver=#{@receiver}")
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      redirect_to(action: :personal_message, receiver: message_params[:receiver])
    else
      flash.now[:alert] = "An Error occured while sending your message"
      render 'welcome/lihp'
    end
  end



  private
  def message_params
    params.require(:message).permit(:content, :sender, :receiver)
  end

  def personal_message_params
    params.permit(:receiver)
  end
end
