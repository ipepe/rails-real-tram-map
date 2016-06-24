Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :trams, only: [:index]
    end
  end
end
