Rails.application.routes.draw do
  resources :logs

  root 'logs#index'

  get 'test' => 'logs#test'
  post 'test' => 'logs#test'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
