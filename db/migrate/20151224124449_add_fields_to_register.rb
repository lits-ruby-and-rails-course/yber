class AddFieldsToRegister < ActiveRecord::Migration
  def change
    change_table :users do |u|
      u.boolean :terms
    end
    change_table :profiles do |p|
      p.integer :role
      p.index :role
    end
  end
end
