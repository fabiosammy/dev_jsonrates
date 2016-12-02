Rails.application.routes.draw do
  root 'home#index'
  get '/update_stocks', as: :update_stocks, to: 'home#update_stocks'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
