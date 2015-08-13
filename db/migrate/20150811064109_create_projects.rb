class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :app_type
      t.string :platform
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
