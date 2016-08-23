class CreateStorageUnits < ActiveRecord::Migration
  def change
    create_table :storage_units do |t|
      t.string :name
      t.string :email
      t.string :telephone
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :service_time_from
      t.string :service_time_to

      t.timestamps null: false
    end
  end
end
