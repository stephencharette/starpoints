class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :credit_card

  has_one :user, through: :credit_card

  validates_uniqueness_of :amount, scope: %i[transaction_date memo amount]

  validates_presence_of :transaction_date, :amount
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
