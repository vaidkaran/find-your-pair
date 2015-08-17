class CreateTechnologies < ActiveRecord::Migration
  def change
    create_table :technologies do |t|
      t.string :name
      t.integer :user_id, index: true

      t.timestamps
    end
  end
end
