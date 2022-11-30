json.extract! transaction, :id, :memo, :category_id, :credit_card_id, :amount, :transaction_date, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
