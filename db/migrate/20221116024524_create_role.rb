class CreateRole < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.boolean :admin, default: false

      t.references :user
      t.timestamps
    end
  end
end
