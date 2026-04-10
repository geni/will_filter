# Rails 3+ application configuration
# This file is only used when running with Rails 3.0+

require_relative 'boot'

if defined?(Rails::Application)
  # Rails 3.0+ - explicitly require the components we need
  require 'active_record/railtie'
  require 'action_controller/railtie'
  require 'action_mailer/railtie' if defined?(ActionMailer)
  require 'active_resource/railtie' if defined?(ActiveResource)

  module WillFilter
    class Application < Rails::Application
      config.time_zone = 'UTC'
      config.encoding = "utf-8"

      # Rails 3.0 - configure deprecation warnings for test environment
      config.active_support.deprecation = :stderr if Rails.env.test?
    end
  end

  # Require gems after application is defined
  Bundler.require(:default, Rails.env) if defined?(Bundler)

  # Initialize the application
  WillFilter::Application.initialize!
end
