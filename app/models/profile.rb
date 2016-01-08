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
#  role       :integer
#

class Profile < ActiveRecord::Base
  enum role: [:rider, :driver]

  belongs_to :user, required: true
  has_one :car

  validates :phone, :city, :role, presence: true
  validates :user_id, uniqueness: true
  validates :car_phone, uniqueness: true, allow_blank: true
end
