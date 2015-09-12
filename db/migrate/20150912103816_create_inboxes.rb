class CreateInboxes < ActiveRecord::Migration
  def change
    create_table :inboxes do |t|
      t.integer :user_one
      t.integer :user_two
      t.text :last_message

      t.timestamps
    end
  end
end
