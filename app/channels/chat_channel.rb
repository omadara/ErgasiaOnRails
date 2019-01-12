class ChatChannel < ApplicationCable::Channel

  def subscribed
    if params[:type] == "new_messages_subscription"
      stream_for current_user
    elsif normal_chat?
      # if they are not friends they cant chat (security check)
      return unless Friend.are_friends?(current_user.id, param_friend_id)
      stream_for friendChatRoom
    elsif group_chat?
      # if user doesnt belong to group he cant chat (security check)
      groupChatRoom = Chatroom.find_by_id(param_group_id)
      return unless groupChatRoom.contains_user?(current_user.id)
      stream_for groupChatRoom
    end
  end

  # ======= methods called from client with perform() ========
  def getChatMessageHistory
    chatroom = normal_chat? ? friendChatRoom : groupChatRoom
    messages = chatroom.messages.map{|m| formatMsgForClient(m)}
    ChatChannel.broadcast_to(chatroom, {event: "message_history", messages: messages})
  end

  def sendChatMessage(data)
    chatroom = normal_chat? ? friendChatRoom : groupChatRoom
    message = Message.new(chatroom: chatroom, user: current_user, content: data["msg"])
    if message.save
      ChatChannel.broadcast_to(chatroom, {event: "message", message: formatMsgForClient(message)})
      if normal_chat?
        # tell friend that current_user send him a message so his chatPopup open automatically
        ChatChannel.broadcast_to(User.find_by_id(param_friend_id),
                               {friend_id: current_user.id, friend_name: current_user.full_name})
      end
    end
  end


  private
  def param_chat_id
    params[:chatId]
  end
  alias param_friend_id param_chat_id
  alias param_group_id param_chat_id

  # if chatroom doesnt exist yet, create it
  def friendChatRoom
    Chatroom.create_or_find_by_user_ids([current_user.id, param_friend_id])
  end

  def groupChatRoom
    Chatroom.find_by_id(param_group_id)
  end

  def formatMsgForClient(message)
    {msg: message.content, user: message.user.full_name, time: message.created_at.strftime("%H:%M")}
  end

  def normal_chat?
    params[:type] == "chat_subscription"
  end

  def group_chat?
    params[:type] == "chat_subscription_group"
  end

end
