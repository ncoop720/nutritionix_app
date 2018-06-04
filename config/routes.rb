Rails.application.routes.draw do
  resources :logs

  root 'logs#index'

  get 'search_food' => 'logs#search_food'
  post 'search_food' => 'logs#search_food'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
