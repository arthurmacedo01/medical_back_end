Rails.application.routes.draw do
    
  namespace :api do
    namespace :v1 do
        resources :patients
        resources :immunotherapies
      end  
  end

  get "/healthcheck", to: proc { [200, {}, ["success"]] }
end