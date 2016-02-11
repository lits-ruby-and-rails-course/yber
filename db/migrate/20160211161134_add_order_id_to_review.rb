class AddOrderIdToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :order_id, :integer
    add_index :reviews, :order_id
  end
end
