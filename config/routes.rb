Rails.application.routes.draw do
  devise_for :users

  resources :families, only: %i[index]

  resources :tasks, only: %i[index new create update]
  get "/tasks/:id", to: "tasks#validate", as: "task_validate"

  resources :goals, only: %i[index]
  get "/goads/:id", to: "goals#add_points", as: "add_points"

  resources :punishments, only: %i[index new create]

  resources :chatrooms, only: :show do
    resources :messages, only: :create
  end

  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
