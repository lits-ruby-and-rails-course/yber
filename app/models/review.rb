# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  type       :string
#  rider_id   :integer
#  driver_id  :integer
#  stars      :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Review < ActiveRecord::Base
  include DriverRiderble
  validates :rider_id, :driver_id,:stars, presence: true
  validates :stars, length: { in: 0..10}
  validates :text, length: {maximum: 250}
end
