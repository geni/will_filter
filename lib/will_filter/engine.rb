# Rails Engine for WillFilter
module WillFilter
  class Engine < ::Rails::Engine
    isolate_namespace WillFilter

    # Configure asset paths for the engine
#    initializer "will_filter.assets" do |app|
#      app.config.assets.paths << root.join("app", "assets")
#    end

    config.after_initialize do
      # Load in correct order: core_ext, will_filter base files, then containers
      root = File.dirname(__FILE__) + "/../.."

      # Load core extensions first
      Dir[File.expand_path("#{root}/lib/core_ext/**/*.rb")].sort.each do |file|
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
