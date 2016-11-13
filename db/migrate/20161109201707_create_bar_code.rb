class CreateBarCode < ActiveRecord::Migration
  def change
    create_table :bar_codes do |t|
    	t.string :code
    	t.integer :amount
    	t.references :product_type, index: true, foreign_key: true
    end
  end
end
