Busykoala::Application.routes.draw do
  resources :devices, :only => [ :index, :update ]
end
