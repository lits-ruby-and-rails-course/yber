class ChangeCarNumberTypeInProfile < ActiveRecord::Migration
  def change
    change_column :profiles, :car_phone, :text
  end
end
