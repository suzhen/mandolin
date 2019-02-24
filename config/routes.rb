Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'

  namespace :api do
    namespace :v1 do
      resources :playlists, only: [:show, :create, :update, :destroy]
      resources :demos, only: [:create, :update]
      resources :songs do
        resources :tags
        resources :melody_copies
        resources :lyric_copies
        resources :producer_copies
        resources :recording_copies
      end
    end
  end
end
