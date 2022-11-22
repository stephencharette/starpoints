class CardImage < ApplicationRecord
  has_many :credit_card_images, dependent: :destroy

  has_one_attached :image
end
