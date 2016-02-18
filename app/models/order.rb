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
  has_many :reviews

  include DriverRiderble
  validates :status,
            :price,
            :rider_id,
            :location_to,
            :location_from, presence: true
  validates :pessengers,
            presence: true,
            inclusion: {in: 1..5, message: "You can have a ride for five passengers maximum"}
  validates :driver_id, presence: true, if: "status != pending"


  # driver_id prsesnce !pending

end
