Rails.application.routes.draw do
  get '/find-a-notary', to: 'members#show', as: 'member'
  mount Optimadmin::Engine => "/admin"
  root to: "application#index"
end
Optimadmin::Engine.routes.draw do
  get 'members/show'

end
