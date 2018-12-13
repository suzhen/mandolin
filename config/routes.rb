Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'

  namespace :api do
    namespace :v1 do
      resources :playlists, only: [:show, :create, :update, :destroy]
      resources :songs, only: [:update] do
        resources :tags
      end
    end
  end
end
