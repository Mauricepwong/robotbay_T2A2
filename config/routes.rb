Rails
  .application
  .routes
  .draw do
    get 'robots', to: 'robots#index', as: 'robots'
    get 'robots/new', to: 'robots#new', as: 'new_robot'
    post 'robots', to: 'robots#create'
    get 'robots/:id', to: 'robots#show', as: 'robot'
    get 'robots/:id/edit', to: 'robots#edit', as: 'edit_robot'
    put 'robots/:id', to: 'robots#update'
    patch 'robots/:id', to: 'robots#update'
    delete 'robots/:id', to: 'robots#destroy'

    get 'checkout/success', to: 'transactions#success'
    get 'checkout/cancel', to: 'transactions#cancel'
    post 'transactions', to: 'transactions#create', as: 'transactions'

    get '/profile', to: 'users#show', as: 'user'
    get '/profile/myrobots', to: 'robots#myrobots', as: 'my_robots'
    
    devise_for :users
    root 'home#index'
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
