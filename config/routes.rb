# Rails 2.3 / 3.0 compatible routes
if defined?(ActionController::Routing::Routes)
  # Rails 2.3
  ActionController::Routing::Routes.draw do |map|
    map.connect 'wf/filter/:action', :controller => 'wf/filter'
    map.connect 'wf/calendar/:action', :controller => 'wf/calendar'
    map.connect 'wf/exporter/:action', :controller => 'wf/exporter'
  end
else
  # Rails 3.0+
  Rails.application.routes.draw do
    match 'wf/filter/:action' => 'wf/filter#:action'
    match 'wf/calendar/:action' => 'wf/calendar#:action'
    match 'wf/exporter/:action' => 'wf/exporter#:action'
  end
end
