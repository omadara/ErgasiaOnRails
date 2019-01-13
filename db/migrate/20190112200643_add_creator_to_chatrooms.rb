class AddCreatorToChatrooms < ActiveRecord::Migration[5.1]
  def change
    add_reference :chatrooms,:user
  end
end
