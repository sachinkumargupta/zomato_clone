Rails.application.routes.draw do
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  get '/restaurants/:id/location', to: 'restaurants#location', as: 'restaurant_location'
  
  resources :restaurants do  
    resources :reviews
    resources :images
    resources :food_items 
    resources :orders
    resources :book_tables
    collection do  
      get 'search'
    end
  end

  root "restaurants#index"
end
