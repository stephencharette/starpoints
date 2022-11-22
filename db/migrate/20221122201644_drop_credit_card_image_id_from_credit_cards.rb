class DropCreditCardImageIdFromCreditCards < ActiveRecord::Migration[7.0]
  def change
    remove_column :credit_cards, :credit_card_image_id
  end
end
