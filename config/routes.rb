Pearl::Application.routes.draw do
  devise_for :users

  resources :users, :only => [:index, :show, :destroy] do
    post :select_group, :on => :collection
    get :edit_profile, :on => :collection
    post :update_profile, :on => :collection
    get :cancel_user, :on => :collection
  end

  resources :projects do
    get :finish, :on => :collection
    resources :documents
  end

  resources :papers do
    resources :documents
  end

  resources :patents do
    resources :documents
  end

  match '/theses/my' => 'theses#my'
  resources :theses do
    resources :documents
  end

  resources :reviews, :only => [:create, :destroy]

  match '/dailies/my(/:date)' => 'dailies#my'
  match '/dailies/group(/:date)' => 'dailies#group'
  match '/dailies/subgroup(/:date)' => 'dailies#subgroup'
  resources :dailies, :only => [:index, :show, :edit, :create, :update]

  resources :comments, :only => [:create, :destroy]

  match '/plans/user(/:id)' => 'plans#user'
  resources :plans do
    get :update_status, :on => :collection
  end

  resources :groups

  match '/home/index/(/:all)' => 'home#index'

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
