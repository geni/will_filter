def next?
  File.basename(__FILE__) == "Gemfile.next"
end
# frozen_string_literal: true

source "http://rubygems.org"

gemspec

if next?
  gem 'rails', '~> 3.1.0'
  gem 'will_paginate', '~> 3.0.7'     # Rails 3.1 compatible version
else
  gem 'rails', '3.0.20'
  gem 'will_paginate', '3.0.0'        # Rails 3.0 compatible version
end

  gem 'dynamic_form'                  # For error_messages_for helper

group :development, :test do
  gem 'method_source'
  gem 'mocha', '0.11.4', :require => false
  gem 'rake'
  gem 'simplecov', :require => false
  gem 'sqlite3', '1.6.9'
  gem 'test-unit', '3.6.2' # >3.6.3 have problems with elapsed_time
end

group :vscode do
  # TBD
end
