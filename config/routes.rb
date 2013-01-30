EmagazynierApp::Application.routes.draw do

  # sklep
  match 'sklepy', to: 'shops#index'
  match 'sklepy/(:name)', to: 'shops#firmemail'
  match 'sklepy/firma/(:name)', to: 'shops#firm'
  match 'sklepy/produkt/(:name)' => 'shops#new_order', :via => :get
  match 'sklepy/produkt/(:name)' => 'shops#create_order', :via => :post

  #raporty
  match 'raporty' => 'documents#new_report', :via => :get
  match 'raporty' => 'documents#create_report', :via => :post

  # domyslny routing CRUD
  resources :documents

  resources :quantities

  resources :firms

  resources :locations

  # get "static_pages/home"
  root to: 'static_pages#home'
  
  # match 'products/editPrice' => 'products#editPrice'
  match 'products/editQuantity' => 'products#editQuantity'
  resources :products

  resources :units

  resources :categories

  #tworzymy resources, wszystkie siezki REST dla user
  # get "users/new"
  resources :users

  #logowanie
  resources :sessions, only: [:new, :create, :destroy]
  match '/zaloguj', to: 'sessions#new'
  match '/wyloguj', to: 'sessions#destroy', via: :delete
  #rejestracja nowego uzytkownika
  match '/rejestracja', to: 'users#new'
  #aktywacja konta
  match '/aktywacja/(:id)', to: 'sessions#active'


 

  # get "static_pages/help"
  match '/pomoc', to: 'static_pages#help'
  
  # get "static_pages/how"
  match '/jak', to: 'static_pages#how'
  
  # get "static_pages/pricing"
  match '/cennik', to: 'static_pages#pricing'
  
  #get "static_pages/contact"
  match '/kontakt', to: 'static_pages#contact'

  #for test -> rspec spec/requests/* - generuje nazwana sciezke static_pages_index -> czyli istnieje static_pages_index_path
  # match 'static_pages/index' => 'static_pages#home'
  match '/index' => 'static_pages#home'

  #dla takiego linku:  match '/static_pages/index'
  #bedziemy mieli taka sciezke static_pages_index_path

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
  # root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
