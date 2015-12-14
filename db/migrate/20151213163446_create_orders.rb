class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :rider_id
      t.integer :order_id
      t.string :location_to
      t.string :location_from
      t.string :status
      t.integer :price
      t.text :description

      t.timestamps null: false
    end
  end
end
