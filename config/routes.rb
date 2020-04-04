Rails.application.routes.draw do

  root to: 'home#index'
  # topページ
  root 'users#show'
  # ↑編集予定
  get 'home/index'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get 'follows'
      get 'followers'
    end
  end
  # resource :relationships, only: [:create, :destroy]
  post 'follow/:id' => 'relationships#create', as: "follow"
  # フォローする
  delete 'unfollow/:id' => 'relationships#destroy', as: "unfollow"
  # フォローを外す
  resources :books, only: [:show, :index, :edit, :create, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resource :book_comments, only: [:create, :destroy]
end
  # deviseを使用する際にURLとしてusersを含むこと

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
