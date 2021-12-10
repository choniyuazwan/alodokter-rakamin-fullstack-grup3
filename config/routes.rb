Rails.application.routes.draw do
  get 'users/Authentication'
  namespace :api do
    namespace :v1 do
      # resources :categories, only: %i[index create destroy]
      # resources :books, only: %i[index create show update destroy]

      resources :users, only: %i[show update]

      post 'users/login', to: 'authentication#create'
      post 'users/register', to: 'users#create'
    end
  end
end
