class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :year
      t.string :brand
      t.string :model
    end

    add_index :cars, [:year, :brand, :model], unique: true
  end
end
