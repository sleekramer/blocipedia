Rails.application.routes.draw do

  get '/about' => 'welcome#about'
  devise_for :users
  resources :users, only: [] do
    resources :wikis
  end

  authenticated :user do
    root 'wikis#index', as: :authenticated
  end

  root to: 'welcome#index'

  resources :charges, only: [:new, :create]
  get '/charges/downgrade' => 'charges#downgrade', as: :downgrade
  post '/to_standard' => 'charges#to_standard', as: :to_standard
end
