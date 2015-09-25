class CreateCircles < ActiveRecord::Migration
  def change
    create_table :circles do |t|
      t.string :name
      t.text :motive
      t.text :description

      t.timestamps
    end
  end
end
