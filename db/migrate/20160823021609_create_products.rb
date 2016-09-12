class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :product_type, index: true, foreign_key: true
      t.float :quantity, default: 0
      t.date :expiration_date

      t.timestamps null: false
    end
  end
end
