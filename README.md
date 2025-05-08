# WillFilter

will_filter is a Rails engine plugin that extends the functionality of will_paginate by adding filters to your pages.

## Preamble

If you ever had to build an admin tool for your web site that displayed a list of objects that can be filtered using
various criteria, this plugin will make your life easier. Adding a filtered page can now be
a matter of adding two lines of code - one to your controller and one to your view. See examples below.

For advanced samples of how to use the filters, please download and install the following project:

http://github.com/berk/will_filter_examples

## Installation

Add the following line to Gemfile:

```ruby
# Gemfile
gem 'will_filter', :git => 'https://github.com/geni/will_filter.git', :branch => 'rails-8.0.x'
```

## Testing

```sh
# run all tests and generate coverage report in coverage subdir
bundle exec rails db:create
bundle exec rails test
```

## Upgrading

```sh
git checkout -b rails-x.y.z
gem install rails-x.y.z

# generate new engine subdir. copy files over and test.
rails plugin new will_filter --rc=.railsrc
```

This will create a new engine in the will_filter subdirectory.
You should copy the files over, then make sure the tests pass.

## References

[Rails Engines](https://guides.rubyonrails.org/engines.html)
