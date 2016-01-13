class RemoveRoleFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :role, :integer
  end
end
