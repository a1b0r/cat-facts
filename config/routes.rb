Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "cat#index"
  get "/list", to: "cat#list"
  get "/album", to: "cat#album"
  get "/show", to: "cat#show"
end