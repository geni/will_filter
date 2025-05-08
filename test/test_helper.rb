# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

unless defined?($SKIP_COVERAGE)
  require 'simplecov'
  SimpleCov.start do
    add_filter 'config'
    add_filter 'db'
    add_filter 'test'
    add_filter 'vendor'
  end
end

class Object
  def tap_pp(*args)
    pp [*args, self]
    self
  end
end

require_relative "../test/dummy/config/environment"
ActiveRecord::Migrator.migrations_paths = [ File.expand_path("../test/dummy/db/migrate", __dir__) ]
ActiveRecord::Migrator.migrations_paths << File.expand_path("../db/migrate", __dir__)
require "rails/test_help"
