ENV['RAILS_ENV'] = 'test'

module CaptureRubyWarnings
  def warn(message)
    return if message =~ /assigned but unused variable/
    return if caller[0] =~ /vendor/ || message =~ /vendor/ # Ignore warnings from vendored code
    super
  end
end
Warning.extend(CaptureRubyWarnings)

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

require_relative '../config/environment'
require 'will_paginate'

# create database tables
Dir[File.expand_path(File.dirname(__FILE__) + '/../db/migrate/*.rb')].each do |file|
  require file
end

ActiveRecord::Migration.verbose = true
ActiveRecord::Migrator.migrate("db/migrate/")