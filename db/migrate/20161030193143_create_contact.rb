class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.string :email
    	t.string :first_name
    	t.string :last_name
    	t.string :telephone
    end
  end
end