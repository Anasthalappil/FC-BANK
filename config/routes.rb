Rails.application.routes.draw do
  get 'transfer/index'
  get 'withdraw/index'
  get 'deposit/index'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'

  get 'sign_up', to: 'registrations#new'
  post 'sign_up', to: 'registrations#create'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create', as: 'log_in'
  delete 'logout', to: 'sessions#destroy'
  get 'password', to: 'passwords#edit', as: 'edit_password'
  patch 'password', to: 'passwords#update'
  get 'password/reset', to: 'password_resets#new'
  post 'password/reset', to: 'password_resets#create'
  get 'password/reset/edit', to: 'password_resets#edit'
  patch 'password/reset/edit', to: 'password_resets#update'
  get 'home', to: 'homes#home'
  post 'home', to: 'homes#create'
  get 'new', to: 'homes#new'
  get 'deposit', to: 'deposit#index'
  post 'deposit', to: 'deposit#update'
  get 'withdraw', to: 'withdraw#index'
  post 'withdraw', to: 'withdraw#update'
  get 'transfer', to: 'transfer#index'
  patch 'transfer_fetch', to: 'transfer#fetch'
  patch 'transfer_send', to: 'send#sending'
  post 'tran_history', to: 'send#tran_history'
  post 'tran_history', to: 'deposit#tran_history'
  post 'tran_history', to: 'withdraw#tran_history'
  get 'show_history', to: 'homes#show'
  get 'statement', to: 'homes#report'
end
