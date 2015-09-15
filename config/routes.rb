Rails.application.routes.draw do
  get '/find-a-notary', to: 'members#show', as: 'member'
  mount Optimadmin::Engine => "/admin"
  root to: "application#index"
end
Optimadmin::Engine.routes.draw do
  resources :member_locations, except: [:show] do
    collection do
      post 'order'
    end
    member do
      get 'toggle'
    end
  end
  resources :members, except: [:show] do
    collection do
      post 'order'
      get 'reimport', as: 'reimport'
    end
    member do
      get 'toggle'
    end
  end
  resources :member_monthly_reports, only: :index do
    collection do
      get :csv
    end
  end
  resources :search_monthly_reports, only: :index do
    collection do
      get :csv
    end
  end
end
