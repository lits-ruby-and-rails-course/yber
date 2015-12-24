# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  city       :string
#  phone      :integer
#  car_id     :integer
#  user_id    :integer
#  car_phone  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  role       :integer
#

class Profile < ActiveRecord::Base

  enum role: [:rider, :driver]

  belongs_to :user
  has_one :car

  validates :user_id, :phone, :city, presence: true
end
