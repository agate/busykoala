Busykoala::Application.routes.draw do
  resources :actions, :only => :create do
    collection do
      get :pattern
    end
  end
  resources :devices, :only => [ :index, :update ]
  root to: 'pages#index'
end
