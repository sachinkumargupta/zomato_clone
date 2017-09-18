Rails.application.routes.draw do
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  get "/restaurants/:id/location", to: 'restaurants#location', as: 'restaurant_location'

  resources :restaurants do  
    resources :reviews, :images, :food_items
  end

  root "restaurants#index"
end
