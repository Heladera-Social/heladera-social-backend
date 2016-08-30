class CreateFavStorageUnits < ActiveRecord::Migration
  def change
    create_table :fav_storage_units do |t|
      t.references :user, index: true, foreign_key: true
      t.references :storage_unit, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
