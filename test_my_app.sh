#!/bin/sh

bundle config --local build.sqlite3 "--enable-system-libraries"
bundle config --local clean true
bundle config --local path vendor/bundle
bundle config --local without vscode

bundle install

rm -rf db/test.sqlite3
bundle exec rake test
