class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :type
      t.integer :rider_id
      t.integer :driver_id
      t.integer :stars
      t.text :text

      t.timestamps null: false
    end
  end
end
