class ChangeBackTermsTypeInUser < ActiveRecord::Migration
  def change
    change_column :users, :terms, :boolean
  end
end
