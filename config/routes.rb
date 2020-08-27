Rails.application.routes.draw do
  resources :recipes 
  root to: 'top#index'
end
