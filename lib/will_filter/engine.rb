module WillFilter
  class Engine < ::Rails::Engine
    isolate_namespace WillFilter

    config.eager_load_paths << root.join('lib')
    config.active_record.yaml_column_permitted_classes = [HashWithIndifferentAccess, Symbol]

    # invoked whenver classes are reloaded
    config.to_prepare do
      if defined?(::ApplicationRecord)
        ::ApplicationRecord.include(WillFilter::Concerns::WillFilterMethods)
      end
    end

  end # class Engine
end # module WillFilter

require 'will_filter/object_extensions'
require 'will_paginate'