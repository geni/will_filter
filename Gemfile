# frozen_string_literal: true

source "http://rubygems.org"

gemspec

gem 'next_rails'
gem 'rails', '~> 3.2.0'
gem 'will_paginate', '~> 3.0.7'
gem 'dynamic_form'                  # For error_messages_for helper

group :development, :test do
  gem 'method_source'
  gem 'mocha', '0.11.4', :require => false
  gem 'rake'
  gem 'simplecov', :require => false
  gem 'sqlite3', '~> 1.3.5'
  gem 'test-unit', '3.6.2' # >3.6.3 have problems with elapsed_time
end

group :vscode do
  # TBD
end
