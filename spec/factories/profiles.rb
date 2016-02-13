# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  city       :string
#  phone      :string
#  car_id     :integer
#  user_id    :integer
#  car_phone  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rating     :integer
#

FactoryGirl.define do
  factory :profile do
    city "MyString"
phone 1
car_id 1
user_id 1
car_phone 1
  end

end
