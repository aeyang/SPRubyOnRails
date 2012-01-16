class AddAvatarColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :has_attached_file
  end
end
