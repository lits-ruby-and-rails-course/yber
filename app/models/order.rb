# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  rider_id      :integer
#  driver_id     :integer
#  location_to   :string
#  location_from :string
#  status        :string
#  price         :integer
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Order < ActiveRecord::Base
  include DriverRiderble
end
