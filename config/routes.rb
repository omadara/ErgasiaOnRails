Rails.application.routes.draw do
  root to: 'pages#index'

  get 'register', to: 'pages#register', as: 'register_page'
  post 'register', to: 'pages#register_post', as: 'register_post'

  get 'login', to: 'pages#login', as: 'login_page'
  post 'login', to: 'sessions#login', as: 'login_post'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'login_google', to: redirect('/auth/google_oauth2'), as: 'login_google'
  get 'auth/google_oauth2/callback', to: 'sessions#login_from_google'
  get 'auth/failure', to: redirect('/')

  resources :posts
  get 'posts', to: 'posts#index', as: 'search_posts'
end
