Rails.application.routes.draw do
  root "pages#index"
  resources :shows, only: :index
  get "music",                     to: "albums#index",          as: :albums
  get "albums/:id/download",       to: "albums#download",       as: :download_album
  get "album_tracks/:id/download", to: "album_tracks#download", as: :download_album_track
  resources :photos,      only: :index
  resources :videos,      only: :index
  resources :subscribers, only: [:new, :create]
  post "newsletter_subscribers", to: "subscribers#newsletter"

  namespace :admin do
    concern :orderable do
      patch :reorder, on: :collection
    end

    root   "admin#index"
    get    "sign-in",  to: "sessions#new",     as: :sign_in
    post   "sign-in",  to: "sessions#create"
    delete "sign-out", to: "sessions#destroy", as: :sign_out
    resources :pages,         only: :index
    resources :custom_pages,  except: [:index, :show]
    resources :default_pages, only: [:edit, :update]
    resources :nav_links,     except: :show, concerns: :orderable
    resources :shows,         except: :show
    resources :albums,        except: :show do
      resources :album_tracks, except: :show, concerns: :orderable
    end
    resources :photos,          except: :show
    resources :videos,          except: :show
    resources :player_tracks,   only: [:index, :create, :destroy], concerns: :orderable
    resources :twitter_handles, only: [:index, :create, :destroy]
    patch "tweets/refresh", to: "tweets#refresh", as: :refresh_tweets
    resources :subscribers, except: :show
    resource  :site,        only: [:edit, :update]
  end

  namespace :ckeditor do
    resources :images, only: :create
  end

  get ":slug", to: "pages#show", as: :page
end
