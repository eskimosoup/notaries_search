Rails.application.routes.draw do
  get '/find-a-notary', to: 'members#show', as: 'member'
  mount Optimadmin::Engine => "/admin"
  root to: "application#index"
end
Optimadmin::Engine.routes.draw do
  resources :members, except: [:show] do
    collection do
      post 'order'
      get 'reimport', as: 'reimport'
    end
    member do
      get 'toggle'
    end
  end
end
