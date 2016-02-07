class ChangePriceTypeForOrders < ActiveRecord::Migration
  change_table :orders do |t|
    t.change :price, :float
  end
end