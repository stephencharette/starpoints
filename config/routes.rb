Rails.application.routes.draw do
  resources :card_images, only: %i[index create show new edit]
  resources :credit_cards
  get 'home/index'
  devise_for :users

  root 'home#index'
end
