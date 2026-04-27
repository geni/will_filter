# Rails 3.1+ Engine routes
WillFilter::Engine.routes.draw do
  # Calendar routes
  get 'calendar(/:action)', :controller => 'calendar', :action => 'index'

  # Filter routes - POST actions first
  post 'filter/update_condition', :controller => 'filter', :action => 'update_condition'
  post 'filter/remove_condition', :controller => 'filter', :action => 'remove_condition'
  post 'filter/add_condition', :controller => 'filter', :action => 'add_condition'
  post 'filter/remove_all_conditions', :controller => 'filter', :action => 'remove_all_conditions'
  post 'filter/load_filter', :controller => 'filter', :action => 'load_filter'
  post 'filter/save_filter', :controller => 'filter', :action => 'save_filter'
  post 'filter/update_filter', :controller => 'filter', :action => 'update_filter'
  post 'filter/delete_filter', :controller => 'filter', :action => 'delete_filter'
  get  'filter(/:action)', :controller => 'filter', :action => 'index'

  # Exporter routes
  post 'exporter/export', :controller => 'exporter', :action => 'export'
  get  'exporter(/:action)', :controller => 'exporter', :action => 'index'
end
