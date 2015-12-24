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

require 'rails_helper'

RSpec.describe Profile, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
