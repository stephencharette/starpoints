Rails.application.routes.draw do
  resources :card_images
  resources :credit_cards
  get 'home/index'
  devise_for :users

  root 'home#index'
end
