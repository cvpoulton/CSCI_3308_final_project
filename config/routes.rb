CSCI3308FinalProject::Application.routes.draw do
  root :to => 'account#login'
  match '/login',       to: 'account#login',       via: 'get'
  match '/login_check', to: 'account#login_check', via: 'post'
  match '/new',         to: 'account#new',         via: 'get'
  match '/create',      to: 'account#create',      via: 'post'
  match '/friends',     to: 'account#friends',     via: 'get'
  match '/preferences', to: 'account#preferences', via: 'get'
  match '/update',      to: 'account#update',      via: 'post'

  match '/logout',      to: 'account#logout',      via: 'get'

  match '/send_request',to: 'account#send_request',     via: 'get'
  match '/add',         to: 'account#add',         via: 'get'
  match '/deny',        to: 'account#deny',        via: 'get'
  match '/defriend',    to: 'account#defriend',    via: 'get'

  match '/newsfeed',    to: 'viewing#newsfeed',    via: 'get'
  match '/profile',     to: 'viewing#profile',     via: 'get'

  #get "account/login" # Form to login
  #post "account/login_check" # Actually logs in

  #get "account/new" # Form to make a new account
  #post "account/create"# Actually makes the new account
  
  #get "account/friends"
  #get "account/preferences"

  #get "viewing/newsfeed"
  #get "viewing/profile"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
