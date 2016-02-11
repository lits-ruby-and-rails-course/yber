# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  rider_id   :integer
#  driver_id  :integer
#  stars      :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  owner      :string
#  order_id   :integer
#

class Review < ActiveRecord::Base
  include DriverRiderble
  belongs_to :order
  validates :rider_id, :driver_id, presence: true
  validates :text, length: {in: 15..250}
  validates :stars, inclusion: {in: 0..5}
end