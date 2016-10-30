class AddOpenedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :opened, :boolean, default: false
    add_column :products, :open_date, :date
  end
end
