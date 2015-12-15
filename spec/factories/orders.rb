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

FactoryGirl.define do
  factory :order do
    rider_id 1
order_id 1
location_to "MyString"
location_from "MyString"
status "MyString"
price 1
description "MyText"
  end

end
