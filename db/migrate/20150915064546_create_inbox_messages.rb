class CreateInboxMessages < ActiveRecord::Migration
  def change
    create_table :inbox_messages do |t|
      t.integer :user_id, index: true
      t.integer :chatmate
      t.text :message
      t.boolean :read

      t.timestamps
    end
  end
end
