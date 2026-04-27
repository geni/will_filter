require 'rubygems'

# Patch Rails 3.2 gem files for Ruby 2.7+ compatibility before requiring rails
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

# Apply patches before loading Rails
patch_rails_32_for_ruby_27

# Load BigDecimal compatibility patch before requiring rails
rails_32_bigdecimal_compat = File.expand_path('../../../../lib/core_ext/rails_32_bigdecimal_compat', __FILE__)
require rails_32_bigdecimal_compat if File.exist?("#{rails_32_bigdecimal_compat}.rb")

gemfile = File.expand_path('../../../../Gemfile', __FILE__)

if File.exist?(gemfile)
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
end

$:.unshift File.expand_path('../../../../lib', __FILE__)