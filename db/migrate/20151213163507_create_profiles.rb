class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :city
      t.integer :phone
      t.integer :car_id
      t.integer :user_id
      t.integer :car_phone

      t.timestamps null: false
    end
  end
end
