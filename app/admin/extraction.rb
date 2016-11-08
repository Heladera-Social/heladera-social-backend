ActiveAdmin.register Extraction do

permit_params :user_id, :storage_unit_id, products_attributes: [:product_type_id, :quantity, :expiration_date]

index do
  id_column
  column :user
  column :storage_unit
  actions
end

show do |d|
  attributes_table do
    rows :id
    rows :user
    rows :storage_unit
  end

  panel 'Productos' do
    table_for d.extraction_products do
      column :product_type
      column :quantity
      column :expiration_date
    end
  end
end

end
