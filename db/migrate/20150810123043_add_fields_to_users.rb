class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :profession, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :country, :string
    add_column :users, :tutor, :boolean
    add_column :users, :student, :boolean
    add_column :users, :team, :boolean
  end
end
