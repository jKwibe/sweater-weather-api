Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'forecast#index'
      get 'background', to: 'background#index'
      post 'sign-up', to: 'user#create'
      post 'session', to: 'session#create'
      post 'road_trip', to: 'trip#create'
    end
  end
end
