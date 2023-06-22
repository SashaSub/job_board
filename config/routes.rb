Rails.application.routes.draw do
  get 'user/show'
  get 'user/:id' => 'user#show'
  get 'home/index'
  resources :jobs
 
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'        
      }
  
  resources :applications #, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
