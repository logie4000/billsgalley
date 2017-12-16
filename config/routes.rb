Rails.application.routes.draw do
  resources :recipes do
    collection do
      get :add_ingredient_row
      get :add_direction_row
      get :about
    end

    member do
      patch :add_ingredient
      patch :add_direction
      patch :remove_ingredient
      patch :remove_direction
    end
  end

  resources :users, path_names: { new: 'register' } do
    collection do
      get :change_password
      patch :update_password
      get :register 
      post :authenticate
      get :login
      get :list
      get :logout
    end
  end

  get '/about', to: redirect('recipes/about')
  get '/login', to: redirect('users/login')
  root to: 'users#welcome'
end
