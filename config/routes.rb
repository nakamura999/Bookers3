Rails.application.routes.draw do

  root to: 'home#index'
  # topページ
  root 'users#show'
  # ↑編集予定
  get 'home/index'
  get 'home/about'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # sessions registration メール転送に利用　使用の場合、cnfig/environments/development.rbのusername: paswword入力

  resources :users, only: [:show, :index, :edit, :update] do
    member do
      get 'follows'
      get 'followers'
    end
  end

  # フォロー機能
  post 'follow/:id' => 'relationships#create', as: "follow"
  # フォローする
  delete 'unfollow/:id' => 'relationships#destroy', as: "unfollow"
  # フォローを外す

  # 検索機能
  get '/search' => 'search#search'

  resources :books, only: [:show, :index, :edit, :create, :update, :destroy] do
  resource :favorites, only: [:create, :destroy]
  resource :book_comments, only: [:create, :destroy]
  end

  resources :chats, only: [:create]
  resources :rooms, only: [:create, :show]
  # チャット機能 chat content:text,room name:string,user_roomモデル作成:  chats roomsコントローラー作成 尚,チャットの投票は非同期

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
