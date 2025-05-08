module WillFilter
  class Engine < ::Rails::Engine
    isolate_namespace WillFilter

# TODO: Remove
#initializer('zeitwerk') { |app| app.autoloaders.main.log! }

#    config.autoload_paths   << root.join('lib')
    config.eager_load_paths   << root.join('lib')

  end # class Engine
end # module WillFilter

# config.eager_load_paths << root.join('lib/will_filter/core_ext') Isn't working
# I must not understand it well enough
# So I'm loading them manually
require 'will_filter/object_extensions'
require 'will_filter/active_record_extensions'