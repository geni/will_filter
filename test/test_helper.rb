require 'test/unit'

ENV['RAILS_ENV'] = 'test'

module CaptureRubyWarnings
  def warn(message)
    return if message =~ /assigned but unused variable/
    return if caller[0] =~ /vendor/ || message =~ /vendor/ # Ignore warnings from vendored code
    super
  end
end
Warning.extend(CaptureRubyWarnings)

unless ENV.fetch('SKIP_COVERAGE', false)
  begin
    require 'simplecov'
    SimpleCov.start do
      add_filter 'config'
      add_filter 'db'
      add_filter 'test'
      add_filter 'vendor'
    end
  rescue LoadError
    # SimpleCov not available (Rails 2.3), skip code coverage
  end
end

class Object
  def tap_pp(*args)
    pp [*args, self]
    self
  end
end

require_relative '../config/environment'
require 'will_paginate'

# create database tables
# In Rails 2.3, we need to require migrations manually
# In Rails 3+, Migrator handles this
if defined?(ActiveRecord::VERSION) && ActiveRecord::VERSION::MAJOR < 3
  Dir[File.expand_path(File.dirname(__FILE__) + '/../db/migrate/*.rb')].each do |file|
    require file
  end
end

ActiveRecord::Migration.verbose = true
ActiveRecord::Migrator.migrate("db/migrate/")
