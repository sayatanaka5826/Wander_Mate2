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
    
    resources :users, only: [:show] do
      collection do 
        get "confirm"
        patch "withdraw"
      end
      
      member do
        get "followings"
        get "followers"
      end
      
      resource :relationships, only: [:create, :destroy]
    end
    
    resources :posts, only: [:new,:show,:edit,:create,:destroy,:update] do
      resource :likes, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    
    resources :chats, only: [:index, :create, :show, :destroy]
      
    get "/search" => "searches#search", as: "search"
    
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
