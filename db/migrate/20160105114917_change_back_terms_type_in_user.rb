class ChangeBackTermsTypeInUser < ActiveRecord::Migration
  def change
  	remove_column :users, :terms
    add_column :users, :terms, :boolean
  end
end
