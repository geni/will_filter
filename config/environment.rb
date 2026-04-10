require_relative 'boot'

# Rails 3.0+ uses application.rb
if defined?(Rails::Application)
  require_relative 'application'
else
  # Rails 2.3 initialization
  Rails::Initializer.run do |config|
    config.time_zone = 'UTC'

    # Rails 2.3 LTS specific options
    if config.respond_to?(:rails_lts_options)
      config.rails_lts_options = { :default => :compatible}
    end
  end
end
