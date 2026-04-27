Dummy::Application.routes.draw do
  mount WillFilter::Engine => '/wf'

  root :to => 'things#index'
end
