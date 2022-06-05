class Task < ApplicationRecord
  include AttributesConcern
  VALID_STATES = ['pending', 'procesing', 'completed']
  
  #Associations 
  belongs_to :user

  #validations
  validates_presence_of :name
  validates :state, inclusion: { in: VALID_STATES }

  #scopes
  scope :by_state, -> (value) {where(state: value)}
  scope :by_search, -> (value) { where('name LIKE ?', "%#{value}%")}

  #Callbacks
  before_validation :attributes_strip
  before_create :generate_slug
  before_update :generate_slug, if: :is_name_changed?

  #instance methods

  def pending?
    state == 'pending'
  end

  def processing?
    state == 'procesing'
  end

  def completed?
    state == 'completed'
  end

  def pending!
    update_column(:state, 'pending')
  end

  def processing!
    update_column(:state, 'processing')
  end

  def completed!
    update_column(:state, 'completed')
  end

  private
    def generate_slug
      if (self.new_record? && Task.exists?(name: self.name)) || (!self.new_record? && Task.where(name: self.name).where.not(id: self&.id).exists?)
        self.slug = "#{name.to_s.parameterize}-#{SecureRandom.hex(5)}"
      else
        self.slug = name.to_s.parameterize
      end
    end

    def is_name_changed?
      self.name_changed?
    end
end
