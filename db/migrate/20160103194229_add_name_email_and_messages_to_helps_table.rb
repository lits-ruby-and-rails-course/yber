class AddNameEmailAndMessagesToHelpsTable < ActiveRecord::Migration
  def change
    add_column :helps, :name, :string
    add_column :helps, :email, :string
    add_column :helps, :messages, :text
  end
end
