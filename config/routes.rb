# config/routes.rb
Rails.application.routes.draw do

  # ユーザー側
  devise_for :users,skip: [:passwords], controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
  }

  devise_scope :user do
    post "public/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'followed' => 'homes#followed'
    get 'notfound' => 'homes#notfound'
    post 'search' => 'searches#search'

    scope :settings do
      get 'profile' => 'users#edit'
      patch 'profile' => 'users#update'
      get  'deactivate' => 'users#confirm'
      patch 'deactivate' => 'users#deactivate'
    end

    resources :users, only: :show, param: :custom_identifier do
      resource :relationships, only: [:create, :update, :destroy]
      get "likes" => 'users#likes'
    	get "following" => 'relationships#following'
    	get "followers" => 'relationships#followers'
    end

    resources :posts, only: [:new, :show, :create, :destroy] do
      get 'confirm', on: :collection
      resource :like, only: [:create, :destroy]
      resources :comments, only: [:create, :update, :destroy, :edit]
    end

    resources :labels, only: [:index, :edit, :create, :update, :destroy]

    resources :punches do
      post 'start', on: :collection
      patch 'stop', on: :member
    end

    resources :notifications, only: [:index, :update]

  end


  # 管理者側
  devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
    resources :labels, only: [:index, :show, :destroy]
  end


  # render後にブラウザリロードした時、Routing Errorにならないように設定
  get 'users' => redirect('/users/sign_up')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
