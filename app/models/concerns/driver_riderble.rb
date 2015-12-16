module DriverRiderble
  extend ActiveSupport::Concern

  included do
    belongs_to :rider, foreign_key: :rider_id, class_name: 'User'
    belongs_to :driver, foreign_key: :driver_id, class_name: 'User'
  end
end
