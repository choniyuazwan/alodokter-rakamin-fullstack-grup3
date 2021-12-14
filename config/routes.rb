Rails.application.routes.draw do
  get 'users/Authentication'
  namespace :api do
    namespace :v1 do

      resources :users, only: %i[index show]

      post 'users/login', to: 'authentication#create'
      post 'users/register', to: 'users#create'

      put 'users/:id/update_personal', to: 'users#update_personal'
      put 'users/:id/update_password', to: 'users#update_password'
    end
  end
end
