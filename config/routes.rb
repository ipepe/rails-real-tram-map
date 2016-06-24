Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :trams, only: [:index] do
        collection do
          get :about
        end
      end
    end
  end
end
