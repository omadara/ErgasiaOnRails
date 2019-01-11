class MessagesController < ApplicationController

  # POST /messages
  def create
    message = Message.new(message_params)
    message.user = current_user
    if message.save
      ActionCable.server.broadcast 'messages',
                                   message: message.content,
                                   user: message.user.full_name,
                                   chatroom: message.chatroom.chatroom_id

      head :ok
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require( :message).permit(:user_id,:chatroom_id,:content)
    end
end
