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

FactoryGirl.define do
  factory :review do
    type ""
rider_id 1
driver_id 1
stars 1
text "MyText"
  end

end
