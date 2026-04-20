# Monkey patches for Rails 3.2.x compatibility with Ruby 2.7+

if defined?(ActiveSupport::VERSION) && ActiveSupport::VERSION::STRING =~ /^3\.2\./
  # Fix: BigDecimal.new is deprecated in Ruby 2.7+
  # Rails 3.2's duplicable.rb tries to call BigDecimal.new which doesn't exist
  # We need to define BigDecimal.new as an alias to BigDecimal() kernel method
  require 'bigdecimal'

  BigDecimal.singleton_class.class_eval do
    unless respond_to?(:new)
      def new(*args, **kwargs)
        if kwargs.empty?
          ::Kernel.BigDecimal(*args)
        else
          ::Kernel.BigDecimal(*args, **kwargs)
        end
      end
    end
  end
end
