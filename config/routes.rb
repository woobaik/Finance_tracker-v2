Rails.application.routes.draw do
  devise_for :users, controller: { registrations: 'user/registrations'}
  root to:'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_stocks', to: 'stocks#search'
  get 'search_friends', to: 'users#search'
  resources :users, only: [:show]
  resources :friendships, only: [:destroy]
  resources :user_stocks, only: [:create, :destroy]
end
