Rails.application.routes.draw do
  resources :notes, except: [:show]
  devise_for :users
  root to: "notes#index"
end
