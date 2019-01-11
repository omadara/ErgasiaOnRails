class ChatChannel < ApplicationCable::Channel

  def subscribed
    # params from App.cable.subscriptions.create({params},...) on client
    puts "ChatChannel subscribed params: " << params.inspect
    stream_from "chat_#{params[:room]}"
  end

  # ======= methods called from client with perform() ========
  def hiFromClient
    puts "ChatChannel hiFromClient params: " << params.inspect
    ActionCable.server.broadcast("chat_testroom", {msg: "hello from server"})
  end

end

# Actioncable.server.broadcast(channe_stream_name, data_to_client)
