Rails.application.routes.draw do
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  resources :restaurants do  
    resources :reviews do  
      get 'approved'
    end
    get 'location'
    resources :images
    resources :food_items 
    resources :orders
    resources :book_tables
    collection do  
      get 'search'
      get 'filter'
    end
  end

  root "restaurants#index"
end
