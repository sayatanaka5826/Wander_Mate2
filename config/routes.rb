Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
  registrations: "user/registrations",
  sessions: 'user/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
  }

  scope module: :user do
    root to: 'homes#top'

    get "/users/my_page" => "users#mypage", as: "my_page"
    get "/users/my_page/edit" => "users#edit", as: "edit_mypage"
    patch "/users/my_page" => "users#update", as: "update_mypage"

    resources :users, only: [:show, :destroy] do
      collection do
        get "confirm"
      end

      member do
        get "followings"
        get "followers"
        get "likes"
      end

      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

    resources :posts, only: [:new,:show,:edit,:create,:destroy,:update] do
      resource :likes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end

    resources :chats, only: [:index, :show, :create, :destroy]

    get "/search" => "searches#search", as: "search"

  end

  namespace :admin do
    get "" => "homes#top", as: "top"
    get "/search" => "searches#search", as: "search"

    resources :users, only: [:index, :show, :destroy]

    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
