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
    
    get "/users/my_page" => "users#mypage", as: "mypage"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
