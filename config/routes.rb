Rails.application.routes.draw do

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:create, :index, :edit, :update]
    resources :items, except: [:destroy]
    resources :orders, only: [:show, :update] do
      resources :order_items, only: [:update]
    end
    root to: 'homes#top'
  end

  scope module: :public do
    resources :orders, only: [:new, :index, :show, :create]
    resources :cart_items, only: [:create, :index, :update, :destroy]
    resources :items, only: [:index, :show]
    resources :deliveies, only: [:index, :edit, :create, :update, :destroy]
  end

  get 'customers/my_page' => 'public/customers#show', as: 'my_page'
  get 'customers/information/edit' => 'public/customers#edit', as: 'edit_information'
  patch 'customers/information' => 'public/customers#update', as: 'information'

  #退会機能
  get 'customers/unsubscribe' => 'public/customers#unsubscribe', as: 'unsubscribe'
  patch 'customers/withdraw' => 'public/customers#withdraw', as: 'withdraw'

  delete 'cart_items/destroy_all' => 'public/cart_items#destroy_all', as: 'destroy_all'

  post 'orders/confirm' => 'public/orders#confirm', as: 'confirm'
  get 'orders/complete' => 'public/orders#complete', as: 'complete'

  get 'about' => 'public/homes#about', as: 'about'
  root to: 'public/homes#top'


  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
