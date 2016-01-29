class AddDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :mfrom_lat, :decimal
    add_column :orders, :mfrom_lng, :decimal
    add_column :orders, :mto_lat, :decimal
    add_column :orders, :mto_lng, :decimal
  end
end