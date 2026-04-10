#!/bin/sh

# Usage: time ./claude_test.sh | tee claude.out

# turn on debugging
#set -x

# stop if any command fails
set -e
set -o pipefail

bundle config --local build.sqlite3 "--enable-system-libraries"
bundle config --local clean true
bundle config --local path vendor/bundle
bundle config --local without vscode


# Show which tests are being run and their results
#export TEST_OPTS="--verbose --no-show-detail-immediately"
export TEST_OPTS="--verbose --no-show-detail-immediately --stop-on-failure"

# In case claude made changes to gems
rm -rf vendor/bundle
bundle install
next bundle install

for bx in 'next' 'bundle exec'
do
  rm -f log/test.log

  # Undike for rails 6.1+
  #$bx rails zeitwerk:check

  rm -f db/test.sqlite3
  $bx rake test
done
