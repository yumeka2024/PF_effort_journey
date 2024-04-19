# config/routes.rb
Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followers'
    get 'relationships/following'
  end
  # ユーザー側
  devise_for :users,skip: [:passwords], controllers: {
  registrations: 'public/registrations',
  sessions: 'public/sessions'
  }

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    post '/search', to: 'searches#search', as: :search

    get 'users/profile/edit' => 'users#edit'
    patch 'users/profile' => 'users#update'
    get  'users/confirm' => 'users#confirm'
    patch 'users/withdraw' => 'users#withdraw'
    get 'id/:custom_identifier', to: 'users#show', as: 'user_custom_id'

    resources :posts, only: [:new, :show, :create, :destroy] do
      get 'confirm', on: :collection
      resource :like, only: [:create, :destroy]
      resources :comments, only: [:create, :update, :destroy, :edit]
    end
  end


  # 管理者側
  devise_for :admin,skip: [:passwords], controllers: {
  registrations: 'admin/registrations',
  sessions: "admin/sessions"
  }

  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :posts, only: [:index, :show, :destroy]
    resources :comments, only: [:index, :destroy]
  end


  # render後にブラウザリロードした時、Routing Errorにならないように設定
  get 'users' => redirect('/users/sign_up')
  get 'users/profile' => redirect('users/profile/edit')

  #match '*path', to: redirect('/'), via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
