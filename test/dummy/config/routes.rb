Rails.application.routes.draw do
  mount WillFilter::Engine => "/will_filter"

  root 'foos#index'
end
