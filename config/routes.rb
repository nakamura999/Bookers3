Rails.application.routes.draw do

  root to: 'home#index'
  root 'users#show'
  # ↑編集予定
  get 'home/index'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  resources :books, only: [:show, :index, :edit, :create, :update, :destroy]
  # deviseを使用する際にURLとしてusersを含むこと
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
