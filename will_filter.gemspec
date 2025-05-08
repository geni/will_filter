require_relative 'lib/will_filter/version'

Gem::Specification.new do |gem|
  gem.name        = 'will_filter'
  gem.version     = WillFilter::Version
  gem.authors     = ['Michael Berkovich', 'Scott Steadman']
  gem.email       = ['michael@geni.com', 'scott.steadman@geni.com']
  gem.description = %q{Filtering framework for Rails AcitveRecord models}
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/geni/will_filter.git'

  gem.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  gem.add_dependency 'rails', '~> 8.0.2'
  gem.add_dependency 'will_paginate'
end
