Rails.application.routes.draw do
namespace :admin do
    root to: "homes#top"
    resources :items
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
  namespace :public do
    root to: 'homes#top'
    get "/homes/about" => "homes#about", as: "about"
    resources :items, only: [:index, :show]
    
    get "/customers/my_page" => "customers#show", as: "customers_my_page"
    get "/customers/quit" => "customers#quit", as: "quit"
    patch "/customers/out" => "customers#out", as: "out"
    
    resources :customers, only: [:edit, :update]
    
    delete "/cart_items/destroy_all" => "cart_items#destroy_all", as: "destroy_all"
    post "cart_items/create"=>"cart_items#create",as: "create"
    resources :cart_items, only: [:index, :update, :destroy,:create]
    
    get "/orders/thanx" => "orders#thanx", as: "thanx"
    post "/orders/thanx" => "orders#thanx"
    post "/orders/confirm" => "orders#confirm",as: "confirm"
    resources :orders, only: [:new, :create, :index, :show]
    
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    delete "/addresses/:id"=> "addresses#destroy",as: "addresses_destroy"
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  } 
end