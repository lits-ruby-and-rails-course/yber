class ChangeTermsTypeInUser < ActiveRecord::Migration
  def change
    change_column :users, :terms, :integer
  end
end
