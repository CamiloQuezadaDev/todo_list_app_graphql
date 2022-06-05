class User < ApplicationRecord
  include AttributesConcern

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  #validations 
  validates_presence_of :first_name,:last_name,:username
  validates_uniqueness_of :username

  # Callbacks
  before_save :attributes_strip
end
