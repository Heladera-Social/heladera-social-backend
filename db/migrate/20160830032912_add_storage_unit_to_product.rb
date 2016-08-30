class AddStorageUnitToProduct < ActiveRecord::Migration
  def change
    add_reference :products, :storage_unit, index: true, foreign_key: true
  end
end
