class FixMessagesColumnNames < ActiveRecord::Migration[5.1]
  def change
    drop_table :messages
    create_table :messages do |t|
      t.text :content
      t.references :user, foreign_key: true
      t.references :chatroom, foreign_key: true

      t.timestamps
    end
  end
end
