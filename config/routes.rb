Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/products/new' => 'products#new'

  post '/products/generateall' => 'products#generateall'

  post '/products/deleteall' => 'products#deleteall'
end
