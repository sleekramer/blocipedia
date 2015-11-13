Rails.application.routes.draw do

  get '/about' => 'welcome#about'
  devise_for :users
  resources :users, only: [:show] do
    resources :wikis
  end

  authenticated :user do
    root 'wikis#index', as: :authenticated
  end

  root to: 'welcome#index'
end
