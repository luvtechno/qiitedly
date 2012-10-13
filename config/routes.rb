Qiitedly::Application.routes.draw do
  root to: "users#index"

  resources :users, only: [:index, :show, :create]
  resources :tags, only: [:show]
end
