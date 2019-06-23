Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'visitors#index'

  namespace :api do
    namespace :v1 do
      resources :playlists, only: [:show, :create, :update, :destroy]
      resources :libraries, only: [:show, :create, :update, :destroy]
      resources :contracts, only: [:show, :create, :update, :destroy]
      resources :demos, only: [:create, :update, :destroy]
      resources :boilerplates, only: [:create, :update, :destroy]
      resources :videos, only: [:show, :create, :update, :destroy]
      post "upvideo", to: "videos#upload_media_file"
      post "upboilerplate", to: "boilerplates#upload_file"
      post "upsong", to: "songs#upload_audio_file"
      post "updemo", to: "demos#upload_audio_file"
      post "upcert", to: "songs#upload_cert_file"
      post "uplicence", to: "songs#upload_licence_file"
      post "upcontractpdf", to: "contracts#upload_pdf_file"
      post "upcontractdoc", to: "contracts#upload_doc_file"
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
