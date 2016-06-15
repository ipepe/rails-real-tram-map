Rails.application.routes.draw do
  resources :trams, only: [:index]
end
