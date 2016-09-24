class AddInformationToDonation < ActiveRecord::Migration
  def change
  	add_column :donations, :name, :string
  	add_column :donations, :last_name, :string
  	add_column :donations, :telephone, :string
  end
end
