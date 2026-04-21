#!/bin/sh

# Rails 3.1 requires bundler ~> 1.0, so use bundler 1.17.3
BUNDLER="bundle _1.17.3_"

$BUNDLER config --local build.sqlite3 "--enable-system-libraries"
$BUNDLER config --local clean true
$BUNDLER config --local path vendor/bundle
$BUNDLER config --local without vscode

# Bundler versions may change between builds
rm Gemfile.lock
rm -rf vendor/bundle

$BUNDLER install

rm -f db/test.sqlite3
$BUNDLER exec rake test
