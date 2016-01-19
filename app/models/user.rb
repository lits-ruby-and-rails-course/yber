# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  role                   :integer
#  invitation_token       :string
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string
#  invitations_count      :integer          default(0)
#  terms                  :boolean
#

class User < ActiveRecord::Base
  enum role: [:admin, :driver, :rider]
  # after_initialize :set_default_role, :if => :new_record?
  attr_accessor :login

  devise :invitable,
         :database_authenticatable,
         :registerable,
         :confirmable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :authentication_keys => [:login]

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_one :car, through: :profile
  has_many :orders
  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :terms, acceptance: {accept: true}
  validates :role, presence: true
  validates_associated :profile
  accepts_nested_attributes_for :profile, allow_destroy: true

  # def set_default_role
  #   self.role ||= :user
  # end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(name) = :value OR lower(email) = :value",
                                      { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end
end
