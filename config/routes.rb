BudgetApp::Application.routes.draw do
  resources :votes

  resources :categories

  resources :expenses

  get '/users/:id/feed' => 'users#feed', :as => 'feed', :id => /([^\/])+?/
  get '/users/live-feed' => 'users#live_feed'
  get '/users/more-feed' => 'users#more_feed'

  get '/users/:id/feed_sum' => 'users#feed_sum', :as => 'feed_sum', :id => /([^\/])+?/

  get '/users/:id' => 'users#show', :as => 'user', :id => /([^\/])+?/
  # patch '/users/:id' => 'users#update', :as => 'user', :id => /([^\/])+?/
  # put '/users/:id' => 'users#update', :as => 'user', :id => /([^\/])+?/
  # delete '/users/:id' => 'users#destroy', :as => 'user', :id => /([^\/])+?/

  post "users_upvote_expense" => "users#upvote_expense"
  post "users_downvote_expense" => "users#downvote_expense"

  root 'static_pages#index'
  get '/about' => 'static_pages#about'
  get '/contact' => 'static_pages#contact'

  get '/auth/facebook/callback' => 'sessions#create'
  get '/auth/facebook', :as => 'facebook_login'
  delete '/sign-out' => 'sessions#destroy', :as => 'sign_out'

  get '/users/:id/add-friends' => 'users#add_friends', :as => 'add_friends', :id => /([^\/])+?/

  post '/new-friendship' => 'friendships#new', :as => 'new_friendship'
  post '/accept-friendship' => 'friendships#accept', :as => 'accept_friendship'

  post '/confirm-hash-uid' => "users#confirm_hash_uid"
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
