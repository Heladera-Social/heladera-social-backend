class AddInformationToextraction < ActiveRecord::Migration
  def change
  	add_column :extractions, :name, :string
  	add_column :extractions, :last_name, :string
  	add_column :extractions, :telephone, :string
  end
end
