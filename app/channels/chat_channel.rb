class ChatChannel < ApplicationCable::Channel

  def subscribed
    if params[:friend_id]
      # for security, if they are not friends they cant chat
      return unless Friend.are_friends?(current_user.id, params[:friend_id])
      stream_for friendChatRoom
    end
  end

  # ======= methods called from client with perform() ========
  def getChatMessageHistory
    chatroom = friendChatRoom
    messages = chatroom.messages.map{|m| formatMsgForClient(m)}
    ChatChannel.broadcast_to(chatroom, {event: "message_history", messages: messages})
  end

  def sendChatMessage(data)
    chatroom = friendChatRoom
    message = Message.new(chatroom: chatroom, user: current_user, content: data["msg"])
    if message.save
      ChatChannel.broadcast_to(chatroom, {event: "message", message: formatMsgForClient(message)})
    end
  end


  private
  # if chatroom doesnt exist yet, create it
  def friendChatRoom
    Chatroom.create_or_find_by_user_ids([current_user.id, params[:friend_id]])
  end

  def formatMsgForClient(message)
    {msg: message.content, user: message.user.full_name, time: message.created_at.strftime("%H:%M")}
  end

end
# Actioncable.server.broadcast(channe_stream_name, data_to_client)
