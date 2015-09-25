Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :users
  resources :technologies
  resources :projects
  resources :messages
  resources :circles
  get 'messages/personal_message/:receiver', to: 'messages#personal_message', as: 'personal_message'

  get 'welcome/index'
  get 'welcome/lihp', to: 'welcome#lihp', as: 'lihp'
  get 'welcome/advance_search', to: 'welcome#advance_search', as: 'advance_search'
  get 'welcome/similar_projects', to: 'welcome#similar_projects', as: 'similar_projects'
  get 'welcome/same_technologies', to: 'welcome#same_technologies', as: 'same_technologies'

  # Technologies
  #post 'technologies/create'
  #get 'technologies/new'
  #get 'technologies/destroy'

  # Projects
  #post 'projects/create'
  #get 'projects/new'
  #get 'projects/destroy'

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
