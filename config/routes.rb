Rails.application.routes.draw do
  resources :readings, except: [:index, :new, :edit]

  # Routes for Kalibro Configuration
  resources :kalibro_configurations, except: [:index, :new, :edit]
  get 'kalibro_configurations' => 'kalibro_configurations#all'
  get 'kalibro_configurations/:id/exists' => 'kalibro_configurations#exists'
  get 'kalibro_configurations/:id/metric_configurations_of' => 'kalibro_configurations#metric_configurations_of'

  resources :reading_groups, except: [:index, :new, :edit]
  get 'reading_groups' => 'reading_groups#all'
  get 'reading_groups/:id/exists' => 'reading_groups#exists'
  get 'reading_groups/:id/readings_of' => 'reading_groups#readings_of'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'information#data'

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
