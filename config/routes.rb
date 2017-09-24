Rails.application.routes.draw do
  
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  get 'auth/:provider/callback', to: 'sessions#omni'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get "error", to: "restaurants#error"
  resources :users

  resources :restaurants do  
    resources :reviews do  
      get 'approved'
    end
    get 'location'
    resources :images, except: [:show, :new, :edit, :update]
    resources :food_items 
    resources :orders, except: [:edit, :update]
    resources :book_tables, except: [:edit, :update]
    collection do  
      get 'search'
      get 'filter'
    end
  end

  root "restaurants#index"
  get "*path", to: redirect("/error")
end
