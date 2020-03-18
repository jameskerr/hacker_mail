Rails.application.routes.draw do
  root to: "subscribers#new"
  resources :subscribers, only: [:new, :create, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
