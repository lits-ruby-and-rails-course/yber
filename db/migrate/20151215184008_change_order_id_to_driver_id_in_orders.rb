class ChangeOrderIdToDriverIdInOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :order_id, :driver_id
  end
end
