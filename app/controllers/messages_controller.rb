class MessagesController < ApplicationController
  def index
    @inbox_records = Inbox.all.where("user_one=#{current_user.id}")
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
      save_inbox_data
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

  def save_inbox_data
    #require 'pry'; binding.pry
    inbox_exists = Inbox.all.where("user_one=#{message_params[:sender]} OR user_one=#{message_params[:receiver]}").where("user_two=#{message_params[:sender]} OR user_two=#{message_params[:receiver]}")

    if inbox_exists.empty?
      begin
        Inbox.create({user_one: message_params[:sender], user_two: message_params[:receiver], last_message: message_params[:content]})
        Inbox.create({user_one: message_params[:receiver], user_two: message_params[:sender], last_message: message_params[:content]})
      rescue e
        raise "Exception in saving data to inbox: #{e}"
      end
    else
      begin
        inbox_exists.each do |record|
          inbox = Inbox.find_by_id(record.id)
          inbox.update_attributes({last_message: message_params[:content]})
        end
      rescue e
        raise "Exception in updating data in inbox: #{e}"
      end
    end
  end
end
