class CreateExtractionProducts < ActiveRecord::Migration
  def change
    create_table :extraction_products do |t|
      t.references :product_type, index: true, foreign_key: true
      t.references :extraction, index: true, foreign_key: true
      t.float :required_quantity, default: 0
      t.float :received_quantity, default: 0

      t.timestamps null: false
    end
  end
end
