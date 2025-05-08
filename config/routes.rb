WillFilter::Engine.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'will_filter/filter/:action',   :controller => 'will_filter/filter'
  get 'will_filter/calendar/:action', :controller => 'will_filter/calendar'
  get 'will_filter/exporter/:action', :controller => 'will_filter/exporter'

  # backwards compatability
  get 'wf/filter/:action',   :controller => 'will_filter/filter'
  get 'wf/calendar/:action', :controller => 'will_filter/calendar'
  get 'wf/exporter/:action', :controller => 'will_filter/exporter'
end
