Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', sessions: 'sessions' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bundles, only: [:index, :create, :show]
  resources :bundle_contributions, only: [:create, :update]
  resources :anonymous_tokens, only: :create

  mount ActionCable.server => '/cable'
end
