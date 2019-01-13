class Chatroom < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :user, optional: true
  has_many :messages, dependent: :destroy

  def self.create_or_find_by_user_ids(user_ids)
    chatroom = Chatroom.includes(:users).find{|c| c.users.ids.sort == user_ids.sort}
    if chatroom.blank?
      chatroom = Chatroom.new
      chatroom.user_ids = user_ids
      chatroom.save
    end
    chatroom
  end

  def contains_user?(user_id)
    user_ids.include?(user_id)
  end
end
