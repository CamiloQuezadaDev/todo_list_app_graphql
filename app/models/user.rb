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
  before_validation :attributes_strip

  #instance methods
  def tasks offset:0, limit:10000, state:nil, search:nil
    records = super()

    if state.present?
      records = records.by_state(state)
    end

    if search.present?
      records.by_search(search)
    end

    records = records.pagination(limit, offset)
  end
end
