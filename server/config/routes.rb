Busykoala::Application.routes.draw do
  resources :actions, :only => :create
  resources :devices, :only => [ :index, :update ]
  root to: 'pages#index'
end
