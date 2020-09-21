Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'background', to: 'background#index'
      post 'sign-up', to: 'user#create'
      post 'session', to: 'session#create'
      get 'climbing_routes', to: 'climbing#index'
    end
  end
end
