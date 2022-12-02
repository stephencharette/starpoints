Rails.application.routes.draw do
  resources :transactions
  resources :categories
  resources :card_images
  resources :credit_cards do
    member do
      patch :move
    end
  end

  get 'home/index'
  devise_for :users

  root 'home#index'
end
