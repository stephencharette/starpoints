class CreditCard < ApplicationRecord
  belongs_to :user

  has_one :credit_card_image
  has_one :card_image, through: :credit_card_image

  validates_uniqueness_of :name, scope: :user
end
