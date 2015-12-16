class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :orders, :rider_id
    add_index :orders, :driver_id
    add_index :active_admin_comments, ["resource_id", "resource_type"]
    add_index :active_admin_comments, ["author_id", "author_type"]
    add_index :reviews, :rider_id
    add_index :reviews, :driver_id
    add_index :profiles, :user_id
    add_index :profiles, :car_id
    add_index :users, ["invited_by_id", "invited_by_type"]
  end
end
