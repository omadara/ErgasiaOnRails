class CreateJoinTableForChatroomsAndUsers < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :chatrooms do |t|
      t.index :user_id
      t.index :chatroom_id
    end

  end
end
