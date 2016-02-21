class ChangeTermsTypeInUser < ActiveRecord::Migration
  def change
  	remove_column :users, :terms 
    add_column :users, :terms, :integer
  end
end
