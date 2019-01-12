class Friend < ApplicationRecord
  belongs_to :user1, class_name:'User', foreign_key: 'user1_id'
  belongs_to :user2, class_name:'User', foreign_key: 'user2_id'

  def self.are_friends?(u1_id, u2_id)
    Friend.where('accepted=? AND ((user1_id=? AND user2_id=?) OR (user1_id=? AND user2_id=?))',
                 true, u1_id, u2_id, u2_id, u1_id).any?
  end
end
