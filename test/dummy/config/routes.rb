Rails.application.routes.draw do
  mount WillFilter::Engine => "/wf"

  root 'foos#index'
end
