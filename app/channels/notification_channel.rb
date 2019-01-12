class NotificationChannel < ApplicationCable::Channel
  @@prefix = "ErgasiaOnRails - "

  def subscribed
    stream_for current_user
    stream_from "notifications"
  end

  def self.newUser(name)
    ActionCable.server.broadcast("notifications", {title: @@prefix + "New User!", body: "'#{name}' just registered!"})
  end

  def self.friendRequest(sender_name, receiver_id)
    receiver = User.find_by_id(receiver_id)
    NotificationChannel.broadcast_to(receiver, {title: @@prefix + "Friend Request", body: "'#{sender_name}' sent you a friend request"})
  end

  def self.newPost(category, title)
    ActionCable.server.broadcast("notifications", {title: @@prefix + category, body: title})
  end

  def self.friendLogined(user)
    user.friends.each do |friend|
      NotificationChannel.broadcast_to(friend, {title: @@prefix + "Friend Logined", body: "'#{friend.full_name}' is now online"})
    end
  end

end
