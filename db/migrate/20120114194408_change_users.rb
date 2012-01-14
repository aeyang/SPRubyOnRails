class ChangeUsers < ActiveRecord::Migration
  def up
    remove_column :users, :password
    add_column :users, :encrypted_password, :string
    add_column :users, :salt, :string
    add_column :users, :longitude, :float
    add_column :users, :latitude, :float
  end

  def down
    add_column :users, :password, :string
    remove_column :users, :encrypted_password
    remove_column :users, :salt
    remove_column :users, :longitude
    remove_column :users, :latitude
  end
end
