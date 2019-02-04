Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "tasks#index"
  resources :tasks do
    member do
      patch :up
      patch :down
    end
  end

end
