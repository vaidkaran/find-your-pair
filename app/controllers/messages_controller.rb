class MessagesController < ApplicationController
  def index
    @inbox_records = current_user.inbox_messages
  end

  def personal_message
    @sender = current_user.id
    @receiver = personal_message_params[:receiver]
    unless current_user.inbox_messages.empty?
      current_user.inbox_messages.where("chatmate=#{@receiver}").first.update_attributes({read: true})
    end
    @message = Message.new
    @message_thread = Message.all.where("sender=#{@sender} OR sender=#{@receiver}").where("receiver=#{@sender} OR receiver=#{@receiver}")
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      save_inbox_message
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

  def save_inbox_message
    if current_user.inbox_messages.empty?
      begin
        current_user.inbox_messages.create!({chatmate: message_params[:receiver], message: message_params[:content], read: true, sent: true})
        User.find_by_id(message_params[:receiver]).inbox_messages.create!({chatmate: current_user.id, message: message_params[:content], read: false, sent: false})
      rescue e
        raise "Exception in saving data to inbox: #{e}"
      end
    else
      begin
        current_user.inbox_messages.where("chatmate=#{message_params[:receiver]}").first.update_attributes({message: message_params[:content], read: true, sent: true})
        User.find_by_id(message_params[:receiver]).inbox_messages.where("chatmate=#{current_user.id}").first.update_attributes({message: message_params[:content], read: false, sent: false})
      rescue e
        raise "Exception in updating data in inbox: #{e}"
      end
    end
  end

end
