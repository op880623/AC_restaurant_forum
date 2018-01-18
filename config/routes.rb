Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"
  resources :users, only: [:show, :edit, :update]
  resources :categories, only: [:show]
  resources :restaurants, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end

  namespace :admin do
    root "restaurants#index"
    resources :restaurants
    resources :categories
  end
end
