ActiveAdmin.register Donation do

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
    table_for d.products do
      column :product_type
      column :quantity
      column :expiration_date
    end
  end
end

form do |f|
  f.inputs "Detalle De Donacion" do
    f.input :user
    f.input :storage_unit
  end

  f.has_many :products do |product|
    product.input :product_type
    product.input :quantity
    product.input :expiration_date
  end
  f.actions
end

end
