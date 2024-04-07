Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  get "users" => redirect("/users/sign_up")

  # ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    
    resources :users, only: :show, param: :custom_identifier
    get "users/profile/edit" => "users#edit"
    patch "users/profile" => "users#update"
    get  'users/confirm' => 'users#confirm'
    patch 'users/withdraw' => 'users#withdraw'
    
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
