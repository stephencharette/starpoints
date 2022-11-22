class CreateCardImages < ActiveRecord::Migration[7.0]
  def change
    create_table :card_images do |t|
      t.string :name

      t.timestamps
    end
  end
end
