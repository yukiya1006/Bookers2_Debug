Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about"
  get "search" => "searches#search"

  resources :users do
    member do
      get :follows, :followers
      get "search", to: "users#search"
    end
    resource :relationships, only: [:create, :destroy]
  end

  resources :books do
    resource :favorites
    resources :book_comments
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end