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

require 'rails_helper'

RSpec.describe Review, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
