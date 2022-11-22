class AddCardImageToCreditCard < ActiveRecord::Migration[7.0]
  def change
    add_reference :credit_cards, :credit_card_image, index: true
  end
end
