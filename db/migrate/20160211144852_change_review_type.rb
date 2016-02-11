class ChangeReviewType < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.remove :type
      t.string :owner
    end
  end
end
