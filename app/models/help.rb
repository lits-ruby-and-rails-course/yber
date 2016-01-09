class Help < ActiveRecord::Base
  validates :name, length: { minimum: 2, maximum: 30 }
  validates :message, length: { maximum: 400 }
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
