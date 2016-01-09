class CreateHelps < ActiveRecord::Migration
  def change
    create_table :helps do |t|

      t.timestamps null: false
    end
  end
end
