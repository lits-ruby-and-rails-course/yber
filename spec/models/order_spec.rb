# == Schema Information
#
# Table name: orders
#
#  id            :integer          not null, primary key
#  rider_id      :integer
#  order_id      :integer
#  location_to   :string
#  location_from :string
#  status        :string
#  price         :integer
#  description   :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
