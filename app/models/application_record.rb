class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.pagination limit = 10000, offset = 0
    limit ||= 10000
    offset ||= 0
    all.limit(limit).offset(offset)
  end

end
