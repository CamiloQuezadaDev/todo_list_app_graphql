# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  authentication_token   :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  include AttributesConcern

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  #Associations
  has_many :tasks

  #validations 
  validates_presence_of :first_name,:last_name,:username
  validates_uniqueness_of :username

  # Callbacks
  before_create :generate_authentication_token

  #instance methods
  def full_name
    "#{first_name} #{last_name}"
  end

  def tasks offset:0, limit:10000, state:nil, search:nil
    records = super()

    if state.present?
      records = records.by_state(state)
    end

    if search.present?
      records = records.by_search(search)
    end

    records = records.pagination(limit, offset)
  end

  def generate_authentication_token
    if self.authentication_token.nil?
      token = ''
      loop do
        token = Devise.friendly_token(40)
        break token if !User.where(authentication_token: token).exists?
      end
      self.authentication_token = token
    end
  end
end
