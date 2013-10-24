LfdBootstrap::Application.routes.draw do

  
  root :to => 'pages#home', :as => :page_home

  get 'styleguide' => 'pages#styleguide', :as => :page_styleguide

  namespace :api do
    resources :retro_responses do
      resources :votes
    end

    resources :feedback_sessions

    resources :projects do
      match '/feedback_sessions' => 'project_feedback_sessions#index'
    end
  end

  # Passthrough to frontend
  match '/feedback_sessions' => 'pages#spa', :as => :feedback_sessions
  match '/feedback_sessions/*page' => 'pages#spa'
  match '/projects' => 'pages#spa', :as => :projects
  match '/projects/:id' => 'pages#spa', :as => :project
  match '/projects/:id/feedback_sessions' => 'pages#spa', :as => :project_feedback_sessions
  match '/projects/:id/feedback_sessions/new' => 'pages#spa', :as => :project_feedback_session_new
  match '/projects/:id/feedback_sessions/:feedback_session_id' => 'pages#spa', :as => :project_feedback_session
  match '/projects/*page' => 'pages#spa'

  # Users
  # =======================
  devise_for :users
  # resources :users do
  #   # post 'example_route'
  # end



  # resources :organisations

  # get 'about' => 'pages#about', :as => :page_about
  # get 'contact-us' => 'pages#contact_us', :as => :page_contact_us

  # # Dashboard
  # # =======================
  # get 'dashboard' => 'dashboard#index', :as => :dashboard



  # # Events
  # # =======================
  # resources :events
  
  # # Admin namespace
  # # =======================
  # namespace :admin do

  #   # Users
  #   # =======================
  #   resources :users
    
  #   # Dashboard
  #   # =======================
  #   get 'dashboard' => 'dashboard#index', :as => :dashboard
  # end


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
