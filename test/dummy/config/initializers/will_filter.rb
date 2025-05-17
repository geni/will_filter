
Rails.application.config.to_prepare do
  WillFilter.configure do |config|
    config.table_name_prefix = 'wf' unless Rails.env.test?
  end
end
