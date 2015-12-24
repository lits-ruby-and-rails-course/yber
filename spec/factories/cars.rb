# == Schema Information
#
# Table name: cars
#
#  id    :integer          not null, primary key
#  year  :integer
#  brand :string
#  model :string
#

FactoryGirl.define do
  factory :car do
    year 1
brand "MyString"
model "MyString"
  end

end
