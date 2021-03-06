Rails.application.routes.draw do
  
  get 'users/Authentication'
  namespace :api do
    namespace :v1 do

      resources :users, only: %i[index show]
      
      resources :categories, only: %i[index create show]
      resources :reviewers, only: %i[index create show]
      resources :specializations, only: %i[index create show]
      resources :institutions, only: %i[index create show]

      resources :articles, only: %i[index create show]
      resources :combines, only: %i[index show]
      resources :schedules, only: %i[index show]
      resources :bookings, only: %i[index create show]
      
      get 'units', to: 'doc_spe_ins_day_hous#index'
      get 'units/:id', to: 'doc_spe_ins_day_hous#show'

      post 'users/login', to: 'authentication#create'
      post 'users/register', to: 'users#create'

      put 'users/:id/update_personal', to: 'users#update_personal'
      put 'users/:id/update_password', to: 'users#update_password'

      post 'password/forget', to: 'passwords#create'
      get 'password/forget/edit', to: 'passwords#edit'
      patch 'password/forget/edit', to: 'passwords#update'
    end
  end
end
