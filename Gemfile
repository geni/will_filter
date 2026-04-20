# frozen_string_literal: true


source "http://rubygems.org"

def next?
  File.basename(__FILE__) == "Gemfile.next"
end

gemspec

gem 'next_rails'

if next?
  gem 'rails', '~> 3.2.0'
  gem 'sqlite3', '~> 1.3.5'
else
  gem 'rails', '~> 3.1.0'
  gem 'sqlite3', '1.6.9'
end
gem 'will_paginate', '~> 3.0.7'
gem 'dynamic_form'                  # For error_messages_for helper

group :development, :test do
  gem 'method_source'
  gem 'mocha', '0.11.4', :require => false
  gem 'rake'
  gem 'simplecov', :require => false
  gem 'test-unit', '3.6.2' # >3.6.3 have problems with elapsed_time
end

group :vscode do
  # TBD
end
