class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :helps, :messages, :message
  end
end
