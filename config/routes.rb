Rails.application.routes.draw do
  # root get 'homes/index'

   devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

      resources :reviews
      resources :services do
        resources :reviews, only: [:new, :create]
      end
      get 'search', to: 'reviews#location_service_name'
end
