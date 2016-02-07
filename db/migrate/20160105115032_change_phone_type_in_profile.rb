class ChangePhoneTypeInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :phone, :string
  end
end
