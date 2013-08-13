Enods::Application.routes.draw do
  devise_for :users, :controllers => {:sessions => 'sessions'}


  match "/pay" => "adaptive_payments#pay",               :as => :paypal_return
  match "/cancel" => "adaptive_payments#cancel",         :as => :paypal_cancel
  match "/ipn_notify" => "adaptive_payments#ipn_notify", :as => :paypal_ipn

  resources :admins do
    collection do
      get :products
      get :seller
      get :buyer
      get :non_profit
      get :sales
    end
    member do
      put :confirm_product
    end
  end
  
  resources :causes

  resources :categories
  resources :invitations
  resources :billing_shipping_addresses

  resources :users do
    collection do
      get :buyer
      post :buyer_create
      put :username
    end
  end

  resources :line_items do
    resources :orders
  end
  resources :carts do
    collection do
      get :expire_cart
    end
  end

  resources :products do
    resources :images
    collection do
      get :search
    end
    member do
      get :add_to_cart
      post :favourite
      put :update_favourite
      put :update_mark_favourite
    end
  end

  resources :profiles do
    member do
      get :profile
      put :profile_update
      put :change_password
    end
  end

  match '/auth/:provider/callback' => 'omniauths#create'
  get '/favourites' => 'products#favourites', :as => :favourites
  get '/category' => 'home#category', :as => :category
  post '/create_alert' => 'home#create_alert', :as => :create_alert
  get '/index' => 'home#index', :as => :index
  get '/order_history' => 'profiles#order_history', :as => :order_history
  get '/dashboard' => 'profiles#dashboard', :as => :dashboard
  get '/admin_dashboard' => 'admins#admin_dashboard', :as => :admin_dashboard

  root :to => 'home#index'

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
