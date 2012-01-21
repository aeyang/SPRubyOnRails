class CreateBandUserJoinTable < ActiveRecord::Migration
  def change
    create_table :bands_users, :id => false do |t|
      t.integer :user_id
      t.integer :band_id
    end
  end
end
