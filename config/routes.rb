Rails.application.routes.draw do
  root "sessions#new"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/signup" => "users#new"
  
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  delete "/logout" => "sessions#destroy"
  
  resources :users, :except => :index
  
  resources :posts, :only => [:create, :destroy]
end
