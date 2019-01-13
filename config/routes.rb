Rails.application.routes.draw do
  root to: 'pages#index'

  mount ActionCable.server => '/cable'

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

  get 'user/:id', to: 'user#show', as: 'user'
  get 'user/:id/send_friend_request', to: 'user#send_friend_request', as: 'send_friend_request'
  get 'user/:id/accept_friend_request', to: 'user#accept_friend_request', as: 'accept_friend_request'
  get 'user/:id/decline_friend_request', to: 'user#decline_friend_request', as: 'decline_friend_request'
  get 'user/:id/remove_friend', to: 'user#remove_friend', as: 'remove_friend'

  get 'groups', to: 'groups#index', as: 'groups'
  post 'groups', to: 'groups#create', as: 'create_group'
  post 'group/:id/join', to: 'groups#join', as: 'group_join'
  post 'group/:id/leave', to: 'groups#leave', as: 'group_leave'
  post 'group/:id/transfer_ownership', to: 'groups#transfer', as: 'group_transfer'
  delete 'group/:id', to: 'groups#destroy'
  get 'group/:id', to: 'groups#show', as: 'group'
end
