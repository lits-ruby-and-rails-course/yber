class AddPessengersToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :pessengers, :integer
  end
end
