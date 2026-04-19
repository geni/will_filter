# Rails Engine for WillFilter
module WillFilter
  class Engine < ::Rails::Engine
    isolate_namespace WillFilter

    # Load Arel compatibility patches early
    initializer "will_filter.load_arel_compat", :before => :load_config_initializers do
      require File.expand_path('../../core_ext/arel_visitor_compat', __FILE__)
    end

    config.after_initialize do
      # Load in correct order: core_ext, will_filter base files, then containers
      root = File.dirname(__FILE__) + "/../.."

      # Load core extensions first (excluding arel_visitor_compat which was already loaded)
      Dir[File.expand_path("#{root}/lib/core_ext/**/*.rb")].sort.each do |file|
        next if file.include?('arel_visitor_compat')
        require_or_load file
      end

      # Load will_filter base files (excluding containers directory)
      Dir[File.expand_path("#{root}/lib/will_filter/*.rb")].sort.each do |file|
        next if file.include?('engine.rb') # Skip the engine file itself
        require_or_load file
      end

      # Load will_filter containers last
      Dir[File.expand_path("#{root}/lib/will_filter/containers/*.rb")].sort.each do |file|
        require_or_load file
      end

      # Include helper methods in the main application
      ActiveSupport.on_load(:action_controller) do
        helper WillFilter::Engine.helpers
      end
    end
  end
end
