Rails.application.routes.draw do
  root 'webhooks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :webhooks, only: [:create]
end
