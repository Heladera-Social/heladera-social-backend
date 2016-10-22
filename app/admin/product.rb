ActiveAdmin.register Product do

permit_params :product_type_id, :quantity, :expiration_date

index do
  selectable_column
  id_column
  column :code
  column :label
  column :product_type
  column :quantity
  column :expiration_date
  actions
end

filter :product_type
filter :expiration_date

show do
  attributes_table do
    rows :label
    rows :code
    rows :product_type
    rows :quantity
    rows :expiration_date
  end
end

form do |f|
  f.inputs "Detalle de Producto" do
    f.input :label
    f.input :product_type
    f.input :quantity
    f.input :expiration_date
  end
  f.actions
end

end
