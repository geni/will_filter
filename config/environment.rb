require_relative 'boot'

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.rails_lts_options = { :default => :compatible}
end
