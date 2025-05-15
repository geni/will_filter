module WillFilter
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.filter(opts = {})
      if ActiveRecord::Base == self
        raise WillFilter::FilterException.new("Cannot apply filter to the ActiveRecord::Base object")
      end

      params = opts[:params] || {}

      if opts[:filter]
        case opts[:filter].class.name
          when "String" then filter_class = opts[:filter].constantize
          when "Symbol" then filter_class = opts[:filter].to_s.camelcase.constantize
          else filter_class = opts[:filter]
        end
      else
        filter_class = WillFilter::Filter
      end

      filter_class.new(self).deserialize_from_params(params).results
    end

  end
end
