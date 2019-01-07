Rails.application.routes.draw do
  get 'sessions/login'

  root to: 'pages#index'

  get 'login', to: 'pages#login', as: 'login_page'
  post 'login', to: 'sessions#login', as: 'login_post'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
