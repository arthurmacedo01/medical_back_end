Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :patients
      resources :immunotherapies
      resources :patchs
      resources :allergens
      resources :pricks
      resources :summaries, only: [:show]
    end
  end

  get "/healthcheck", to: proc { [200, {}, ["success"]] }
end
