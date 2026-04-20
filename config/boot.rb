# Don't change this file!
# Configure your app in config/environment.rb and config/environments/*.rb

RAILS_ROOT = "#{File.dirname(__FILE__)}/.." unless defined?(RAILS_ROOT)

module Rails
  class << self
    def boot!
      unless booted?
        preinitialize
        pick_boot.run
      end
    end

    def booted?
      defined? Rails::Initializer
    end

    def pick_boot
      (vendor_rails? ? VendorBoot : GemBoot).new
    end

    def vendor_rails?
      File.exist?("#{RAILS_ROOT}/vendor/rails")
    end

    def preinitialize
      load(preinitializer_path) if File.exist?(preinitializer_path)
    end

    def preinitializer_path
      "#{RAILS_ROOT}/config/preinitializer.rb"
    end
  end

  class Boot
    def run
      load_initializer
    end
  end

  class VendorBoot < Boot
    def load_initializer
      require "#{RAILS_ROOT}/vendor/rails/railties/lib/initializer"
      Rails::Initializer.run(:install_gem_spec_stubs)
      Rails::GemDependency.add_frozen_gem_path
    end
  end

  class GemBoot < Boot
    def load_initializer
      self.class.load_rubygems
      load_rails_gem

      # Patch Rails 3.2 gem files for Ruby 2.7+ compatibility before requiring rails
      patch_rails_32_for_ruby_27

      # Load Rails 3.2 Ruby 2.7 compatibility patches before requiring rails
      rails_32_ruby_27_compat = File.expand_path('../../lib/core_ext/rails_32_ruby_27_compat', __FILE__)
      require rails_32_ruby_27_compat if File.exist?("#{rails_32_ruby_27_compat}.rb")

      require 'rails'

      # Load Arel compatibility patches for Rails 3.2 after rails loads
      rails_31_arel_compat = File.expand_path('../../lib/core_ext/rails_31_arel_compat', __FILE__)
      require rails_31_arel_compat if File.exist?("#{rails_31_arel_compat}.rb")
    end

    def patch_rails_32_for_ruby_27
      # Find Rails 3.2 gems and patch for Ruby 2.7+ compatibility
      return unless defined?(Gem)

      # Patch ActiveSupport for Rails 3.2 + Ruby 2.7+ (BigDecimal.new is deprecated)
      as_32_gem_spec = Gem.loaded_specs.values.find { |spec| spec.name == 'activesupport' && spec.version.to_s =~ /^3\.2\./ }
      if as_32_gem_spec
        duplicable_file = File.join(as_32_gem_spec.full_gem_path, 'lib/active_support/core_ext/object/duplicable.rb')
        if File.exist?(duplicable_file)
          content = File.read(duplicable_file)
          # Fix: BigDecimal.new is deprecated in Ruby 2.7+
          if content.match?(/^\s*BigDecimal\.new\(/) && !content.include?('# PATCHED FOR RUBY 2.7+')
            # Replace BigDecimal.new with Kernel.BigDecimal
            content.gsub!(/BigDecimal\.new\(/, 'Kernel.BigDecimal(')
            # Add marker comment at top
            content = "# PATCHED FOR RUBY 2.7+ - BigDecimal.new replaced with Kernel.BigDecimal\n" + content
            File.write(duplicable_file, content)
          end
        end
      end
    end

    def load_rails_gem
      if version = self.class.gem_version
        gem 'rails', version
      else
        gem 'rails'
      end
    rescue Gem::LoadError => load_error
      if load_error.message =~ /Could not find RubyGem rails/
        STDERR.puts %(Missing the Rails #{version} gem. Please `gem install -v=#{version} rails`, update your RAILS_GEM_VERSION setting in config/environment.rb for the Rails version you do have installed, or comment out RAILS_GEM_VERSION to use the latest version installed.)
        exit 1
      else
        raise
      end
    end

    class << self
      def rubygems_version
        Gem::VERSION
      end

      def gem_version
        if defined? RAILS_GEM_VERSION
          RAILS_GEM_VERSION
        elsif ENV.include?('RAILS_GEM_VERSION')
          ENV['RAILS_GEM_VERSION']
        else
          parse_gem_version(read_environment_rb)
        end
      end

      def load_rubygems
        min_version = '1.3.2'
        require 'rubygems'
        unless rubygems_version >= min_version
          $stderr.puts %Q(Rails requires RubyGems >= #{min_version} (you have #{rubygems_version}). Please `gem update --system` and try again.)
          exit 1
        end

      rescue LoadError
        $stderr.puts %Q(Rails requires RubyGems >= #{min_version}. Please install RubyGems and try again: http://rubygems.rubyforge.org)
        exit 1
      end

      def parse_gem_version(text)
        $1 if text =~ /^[^#]*RAILS_GEM_VERSION\s*=\s*["']([!~<>=]*\s*[\d.]+)["']/
      end

      private
        def read_environment_rb
          File.read("#{RAILS_ROOT}/config/environment.rb")
        end
    end
  end
end

# All that for this:
Rails.boot!

require 'rbconfig'
Config = RbConfig
