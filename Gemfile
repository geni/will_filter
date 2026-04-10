# frozen_string_literal: true
#
# DUAL-BOOT CONFIGURATION
# This Gemfile supports running both Rails 2.3 and Rails 3.0 using the next_rails gem.
#
# Install dependencies:
#   bundle install                      # Install Rails 2.3 dependencies
#   bundle exec next bundle install     # Install Rails 3.0 dependencies
#
# Run with Rails 2.3:
#   bundle exec rails server
#   bundle exec rake test
#
# Run with Rails 3.0:
#   bundle exec next rails server
#   bundle exec next rake test
#
# See docs/rails-upgrade/Rails-2.3-to-3.0-Upgrade-Report.md for details

def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source "http://rubygems.org"

gem 'next_rails'

gemspec

if next?
  # Rails 3.0 dependencies
  gem 'rails', '~> 3.0.0'
  gem 'dynamic_form'                  # For error_messages_for helper
  gem 'rails_xss'                     # Gradual XSS protection migration
else
  # Rails LTS sources for free Community plan
  git 'https://github.com/makandra/rails.git', :branch => '2-3-lts' do
    gem 'rails', '~>2.3.18'
  #  gem 'actionmailer',     :require => false
    gem 'actionpack',       :require => false
    gem 'activerecord',     :require => false
  #  gem 'activeresource',   :require => false
    gem 'activesupport',    :require => false
    gem 'railties',         :require => false
  end
end

group :development, :test do
  gem 'method_source'
  gem 'mocha', '0.11.4', :require => false
  gem 'rake'
  gem 'simplecov',       :require => false if next?
  gem 'sqlite3', '1.6.9'
  gem 'test-unit', '3.6.2' # >3.6.3 have problems with elapsed_time
end

group :vscode do
  # TBD
end
