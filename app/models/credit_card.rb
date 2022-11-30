class CreditCard < ApplicationRecord
  belongs_to :user

  has_one :credit_card_image, dependent: :destroy
  has_one :card_image, through: :credit_card_image

  has_many :transactions

  validates_uniqueness_of :name, scope: :user

  accepts_nested_attributes_for :credit_card_image
end
