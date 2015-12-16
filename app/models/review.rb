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
end
