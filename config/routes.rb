ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "bills"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
  map.resources :bills do |bills|
    bills.add_visitor 'add_visitor', :controller => 'bills', :action => 'add_visitor'
    bills.resources :bill_items
	bills.resources :bill_participants
  end
  
  map.bill_payment 'bill_payments/:bill_item_id/:bill_participant_id/update', :controller => 'bill_payments', :action => 'update'
  
  map.permalink 'bill/:permalink', :controller => 'bills', :action => 'permalink'
  map.connect   'bill/:permalink.:format', :controller => 'bills', :action => 'permalink', :format => nil
  
  map.visitor_permalink 'visitor/:permalink', :controller => 'visitors', :action => 'visitor_permalink'
  map.connect           'visitor/:permalink.:format', :controller => 'visitors', :action => 'visitor_permalink', :format => nil
  
  map.locale  'set_locale', :controller => 'visitors', :action => 'set_locale'
  #map.connect 'set_locale/:locale.:format', :controller => 'visitors', :action => 'set_locale', :format => nil
end
