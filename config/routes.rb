Rails.application.routes.draw do

  scope "/api/v1", defaults: { format: :json } do
    devise_for :users,
               path: "",
               path_names: {
                 sign_in: "login",
                 sign_out: "logout",
                 registration: "signup",
               },
               controllers: {
                 sessions: "users/sessions",
                 registrations: "users/registrations",
               }
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }
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
