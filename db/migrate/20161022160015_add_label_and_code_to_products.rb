class AddLabelAndCodeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :label, :string
    add_column :products, :code, :string
  end
end
