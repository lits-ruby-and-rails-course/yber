# == Schema Information
#
# Table name: cars
#
#  id    :integer          not null, primary key
#  year  :integer
#  brand :string
#  model :string
#

class Car < ActiveRecord::Base
  belongs_to :profile
  validates :year, :brand, :model, presence: true
end
