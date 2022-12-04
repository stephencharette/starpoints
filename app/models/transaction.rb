require 'csv'

class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :credit_card

  has_one :user, through: :credit_card

  validates_uniqueness_of :amount, scope: %i[transaction_date memo amount]

  validates_presence_of :transaction_date, :amount
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  def self.import(params:, user:)
    # Column mappings
    transaction_date = params[:transaction_date].to_i
    credit_card = params[:credit_card].to_i
    category = params[:category].to_i
    amount = params[:amount].to_i
    memo = params[:memo].to_i

    transactions = []
    csv_contents = CSV.read(params[:attachment])
    csv_contents.shift

    ActiveRecord::Base.transaction do
      csv_contents.each do |row|
        next if row[amount].to_f.positive?

        transactions << { transaction_date: row[transaction_date],
                          credit_card_id: row[credit_card].to_i,
                          category_id: Category.last.id,
                          amount: row[amount],
                          memo: row[memo] }
      end

      Transaction.upsert_all(transactions)
    end
  rescue StandardError => e
    nil
  end
end
