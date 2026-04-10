# Monkey patches for Rails 3.0.x compatibility with Ruby 2.7+
# TODO: Remove this file when upgrading to Rails 3.2+

if defined?(ActiveSupport::VERSION) && ActiveSupport::VERSION::STRING =~ /^3\.0\./

  # Fix 1: TimeZone#parse has circular argument reference: def parse(str, now=now)
  # This is invalid in Ruby 2.7+
  module ActiveSupport
    class TimeZone
      def parse(str, now=nil)
        now ||= self.now  # Use self.now as default instead of now=now
        date_parts = Date._parse(str)
        return if date_parts.blank?
        time = Time.parse(str, now) rescue DateTime.parse(str)
        if date_parts[:offset].nil?
          ActiveSupport::TimeWithZone.new(nil, self, time)
        else
          time.in_time_zone(self)
        end
      end
    end
  end

  # Fix 2: BigDecimal#yaml_as doesn't exist in newer Psych (Ruby 2.7+)
  # Prevent the error by defining yaml_as as a no-op if it doesn't exist
  class BigDecimal
    unless respond_to?(:yaml_as)
      def self.yaml_as(tag)
        # No-op for Ruby 2.7+ where yaml_as was removed
      end
    end
  end
end
