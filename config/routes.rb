Rails.application.routes.draw do
  devise_for :users

  resources :families, only: %i[index]

  resources :tasks, only: %i[index new create]

  resources :goals, only: %i[index]

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
