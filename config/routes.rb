Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  get 'change_locale', to: 'application#change_locale'
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

end
