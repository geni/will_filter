Dummy::Application.routes.draw do
  mount WillFilter::Engine => '/will_filter'

  root :to => 'foos#index'
end
