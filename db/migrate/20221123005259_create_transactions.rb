class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :memo
      t.references :category, null: false, foreign_key: true
      t.references :credit_card, null: false, foreign_key: true
      t.decimal :amount
      t.date :transaction_date

      t.timestamps
    end
  end
end
