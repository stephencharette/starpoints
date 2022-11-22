class CreateCreditCardImages < ActiveRecord::Migration[7.0]
  def change
    create_table :credit_card_images do |t|
      t.references :credit_card
      t.references :card_image
      t.timestamps
    end
  end
end
