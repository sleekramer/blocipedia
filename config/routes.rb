Rails.application.routes.draw do

  resources :wikis
  devise_for :users

  root to: 'welcome#index'

  get '/about' => 'welcome#about'
end
