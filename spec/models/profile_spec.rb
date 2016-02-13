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

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
