# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  rider_id      :integer
#  driver_id     :integer
#  location_to   :string
#  location_from :string
#  status        :integer          default(0)
#  price         :float
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  pessengers    :integer
#  mfrom_lat     :decimal(, )
#  mfrom_lng     :decimal(, )
#  mto_lat       :decimal(, )
#  mto_lng       :decimal(, )
#

class Order < ActiveRecord::Base
  enum status: [:pending, :accepted, :completed]

  include DriverRiderble
  validates :rider_id, :location_to, :location_from, presence: true
end
