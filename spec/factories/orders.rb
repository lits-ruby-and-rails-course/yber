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
