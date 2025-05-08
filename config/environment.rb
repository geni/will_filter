require_relative 'boot'

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.rails_lts_options = { :default => :compatible}

  config.active_record.yaml_column_permitted_classes = %w{
    HashWithIndifferentAccess
    Symbol
  }
end
