# Configure YAML permitted classes for Rails LTS
# This is required to safely deserialize YAML columns that contain certain Ruby classes

if defined?(ActiveRecord::Base) && ActiveRecord::Base.respond_to?(:yaml_column_permitted_classes=)
  permitted_classes = [Symbol]

  # Add HashWithIndifferentAccess if it's available
  if defined?(ActiveSupport::HashWithIndifferentAccess)
    permitted_classes << ActiveSupport::HashWithIndifferentAccess
  elsif defined?(HashWithIndifferentAccess)
    permitted_classes << HashWithIndifferentAccess
  end

  ActiveRecord::Base.yaml_column_permitted_classes = permitted_classes
end
