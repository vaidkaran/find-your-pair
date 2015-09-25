class CreateFriendCircles < ActiveRecord::Migration
  def change
    create_table :friend_circles do |t|
      t.integer :user_id
      t.integer :circle_id
      t.integer :user_status
      t.boolean :admin

      t.timestamps
    end
  end
end
