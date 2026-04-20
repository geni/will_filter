# Rails 3.0+ railtie for loading WillFilter
# In Rails 2.3, init.rb is used instead
if defined?(Rails::Railtie)
  module WillFilter
    class Railtie < Rails::Railtie
      # Load Arel compatibility patches early, before after_initialize
      initializer "will_filter.load_arel_compat", :before => :load_config_initializers do
        require File.expand_path('../../core_ext/arel_visitor_compat', __FILE__)
      end

      config.after_initialize do
        # Load in correct order: core_ext, wf base files, then wf containers
        root = File.dirname(__FILE__) + "/../.."

        # Load core extensions first (excluding arel_visitor_compat which was already loaded)
        Dir[File.expand_path("#{root}/lib/core_ext/**/*.rb")].sort.each do |file|
          next if file.include?('arel_visitor_compat')
          require_or_load file
        end

        # Load wf base files (excluding containers directory)
        Dir[File.expand_path("#{root}/lib/will_filter/*.rb")].sort.each do |file|
          require_or_load file
        end

        # Load wf containers last
        Dir[File.expand_path("#{root}/lib/will_filter/containers/*.rb")].sort.each do |file|
          require_or_load file
        end

        ApplicationHelper.send(:include, WillFilter::HelperMethods)
      end
    end
  end
end
