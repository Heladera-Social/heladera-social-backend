class CreateDonationProducts < ActiveRecord::Migration
  def change
    create_table :donation_products do |t|
      t.references :product_type, index: true, foreign_key: true
      t.references :donation, index: true, foreign_key: true
      t.float :quantity, default: 0
      t.date :expiration_date
      t.string :label
      t.string :code

      t.timestamps null: false
    end
  end
end
