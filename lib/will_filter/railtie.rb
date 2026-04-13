# Rails 3.0+ railtie for loading WillFilter
# In Rails 2.3, init.rb is used instead
if defined?(Rails::Railtie)
  module WillFilter
    class Railtie < Rails::Railtie
      config.after_initialize do
        # Load in correct order: core_ext, wf base files, then wf containers
        root = File.dirname(__FILE__) + "/../.."

        # Load core extensions first
        Dir[File.expand_path("#{root}/lib/core_ext/**/*.rb")].sort.each do |file|
          require_or_load file
        end

        # Load wf base files (excluding containers directory)
        Dir[File.expand_path("#{root}/lib/wf/*.rb")].sort.each do |file|
          require_or_load file
        end

        # Load wf containers last
        Dir[File.expand_path("#{root}/lib/wf/containers/*.rb")].sort.each do |file|
          require_or_load file
        end

        ApplicationHelper.send(:include, Wf::HelperMethods)
      end
    end
  end
end
