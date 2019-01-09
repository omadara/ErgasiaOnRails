class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.references :user1, references: :users
      t.references :user2, references: :users

      t.timestamps
    end
  end
end
