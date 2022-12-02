class AddPositionToCreditCard < ActiveRecord::Migration[7.0]
  def change
    add_column :credit_cards, :position, :integer
  end
end
