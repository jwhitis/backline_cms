Rails.application.routes.draw do
  namespace :admin do
    concern :reorderable do
      patch :reorder, on: :collection
    end

    get "/", to: "admin#index"
    get "sign-in", to: "sessions#new", as: :sign_in
    post "sign-in", to: "sessions#create"
    delete "sign-out", to: "sessions#destroy", as: :sign_out
    resources :shows, except: :show
    resources :albums, except: :show do
      resources :album_tracks, concerns: :reorderable, except: :show
    end
    resources :photos, except: :show
    resources :videos, except: :show
    resources :player_tracks, concerns: :reorderable, only: [:index, :create, :destroy]
    get "refresh_player", to: "admin#refresh_player"
    resources :twitter_handles, only: [:index, :create, :destroy]
    patch "tweets/refresh", to: "tweets#refresh", as: :refresh_tweets
  end

  resources :shows, only: :index
  get "music", to: "albums#index", as: :albums
  get "albums/:id/download", to: "albums#download", as: :download_album
  get "album_tracks/:id/download", to: "album_tracks#download", as: :download_album_track
  resources :photos, only: :index
  resources :videos, only: :index
  resources :subscribers, only: [:new, :create]
  root "pages#index"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
