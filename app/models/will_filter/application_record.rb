module WillFilter
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    include Concerns::WillFilterMethods
  end
end
