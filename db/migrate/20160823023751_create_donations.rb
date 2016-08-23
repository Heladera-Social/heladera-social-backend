class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :storage_unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
