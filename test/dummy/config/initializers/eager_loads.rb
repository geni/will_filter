
unless Rails.application.config.eager_load
  Rails.application.config.to_prepare do
    Rails.autoloaders.main.eager_load_dir(Rails.root.join('app/models/filters'))
  end
end