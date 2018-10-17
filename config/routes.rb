Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/products/new' => 'products#new'

  post '/products/save_to_database' => 'products#save_to_database'

  post '/products/save_one_to_database' => 'products#save_one_to_database'

  post '/products/save_another_to_database' => 'products#save_another_to_database'
end
