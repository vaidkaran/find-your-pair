class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_user_id
      t.integer :receiver_user_id
      t.text :message

      t.timestamps
    end
  end
end
