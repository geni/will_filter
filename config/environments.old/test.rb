# Settings specified here will take precedence over those in config/environment.rb

require 'pp'

# This file is evaluated in the context where 'config' variable is available (Rails 2.3)
# or needs to reference Rails.application.config (Rails 3+)
# We check if 'config' is defined to determine which Rails version we're in

if defined?(config)
  # Rails 2.3 - config variable is available
  config.cache_classes = true
  config.whiny_nils = true if config.respond_to?(:whiny_nils=)

  if config.respond_to?(:action_controller)
    config.action_controller.consider_all_requests_local = true
    config.action_controller.perform_caching             = false
    config.action_controller.allow_forgery_protection    = false
    config.action_controller.session = { :key => "_test_session", :secret => "218d878f47b437169e7de9975d2e1286" }
  end

  if config.respond_to?(:action_view)
    config.action_view.cache_template_loading = true
  end

  if config.respond_to?(:action_mailer)
    config.action_mailer.delivery_method = :test
  end
else
  # Rails 3+ - config variable not available, skip environment-specific config
  # The test will load with defaults
end
