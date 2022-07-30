class ApplicationRecord < ActiveRecord::Base
  include AttributesConcern
  
  self.abstract_class = true

  before_validation :attributes_strip

  def self.pagination limit = 10000, offset = 0
    limit ||= 10000
    offset ||= 0
    all.limit(limit).offset(offset)
  end

end
