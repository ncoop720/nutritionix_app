Rails.application.routes.draw do
  devise_for :users
  resources :logs

  root 'logs#index'

  get 'search_food' => 'logs#search_food'
  post 'search_food' => 'logs#search_food'
  get 'add_food' => 'logs#add_food'
  post 'add_food' => 'logs#add_food'
  get 'load_dash' => 'logs#load_dash'
  post 'load_dash' => 'logs#load_dash'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
