class AddDeliveredToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :delivered, :boolean, default: false
  end
end
