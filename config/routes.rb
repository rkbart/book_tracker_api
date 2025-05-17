Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        resources :books, only: [ :index ]
      end

      resources :categories do
        resources :books, only: [ :index ]
      end

      resources :books
    end
  end
end
