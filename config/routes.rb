# Rails 3.1+ Engine routes
WillFilter::Engine.routes.draw do
  match 'filter/:action' => 'will_filter/filter#:action', via: :all
  match 'calendar/:action' => 'will_filter/calendar#:action', via: :all
  match 'exporter/:action' => 'will_filter/exporter#:action', via: :all
end
