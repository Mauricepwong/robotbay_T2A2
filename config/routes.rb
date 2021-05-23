Rails.application.routes.draw do
  get 'robots', to: "robots#index", as: "robots"
  get 'robots/new', to: "robots#new", as: "new_robot"
  post 'robots', to: "robots#create"
  get 'robots/:id', to: "robots#show", as: "robot"
  get 'robots/:id/edit', to: "robots#edit", as: "edit_order"
  put 'robots/:id', to: "robots#update"
  patch 'robots/:id', to: "robots#update"
  
  delete 'robots/:id', to: "robots#destroy"

  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
