Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index', as: :home
  resources :home
  resources :tweets
end
