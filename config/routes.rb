WillFilter::Engine.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get '/filter',                        :to => 'filter#index'
  get '/filter/add_condition',          :to => 'filter#add_condition'
  get '/filter/remove_condition',       :to => 'filter#remove_condition'
  get '/filter/update_condition',       :to => 'filter#update_condition'
  get '/filter/remove_all_conditions',  :to => 'filter#remove_all_conditions'
  get '/filter/save_filter',            :to => 'filter#save_filter'
  get '/filter/load_filter',            :to => 'filter#load_filter'
  get '/filter/update_filter',          :to => 'filter#update_filter'
  get '/filter/delete_filter',          :to => 'filter#delete_filter'

  get '/calendar', :to => 'calendar#index'

  get '/exporter',        :to => 'exporter#index'
  get '/exporter/export', :to => 'exporter#export'

end
