Rails.application.routes.draw do
  devise_for :users

  resources :cards
  resources :lists do 
    
    member do
      put :move # /list/2/move
    end
  end
  
  root 'lists#index'
end
