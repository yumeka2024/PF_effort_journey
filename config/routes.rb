# config/routes.rb
Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  # ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'

    get 'users/profile/edit' => 'users#edit'
    patch 'users/profile' => 'users#update'
    get  'users/confirm' => 'users#confirm'
    patch 'users/withdraw' => 'users#withdraw'
    get 'id/:custom_identifier', to: 'users#show', as: 'user_custom_id'

    resources :posts, only: [:new, :show, :create, :destroy] do
      get 'confirm', on: :collection
    end

  end

  # render後にリロードした時、Routing Errorにならないように設定
  get 'users' => redirect('/users/sign_up')
  get 'users/profile' => redirect('users/profile/edit')

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
