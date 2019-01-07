Rails.application.routes.draw do
  get 'sessions/login'

  root to: 'pages#index'

  get 'login', to: 'pages#login', as: 'login_page'
  post 'login', to: 'sessions#login', as: 'login_post'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'login_google', to: redirect('/auth/google_oauth2'), as: 'login_google'
  get 'auth/google_oauth2/callback', to: 'sessions#login_from_google'
  get 'auth/failure', to: redirect('/')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
