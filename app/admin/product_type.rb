ActiveAdmin.register ProductType do

permit_params :name, :expiration_time, :measurement_unit

index do
  selectable_column
  id_column
  column :name
  column :expiration_time
  column :measurement_unit
  actions
end

filter :name
filter :expiration_time

show do
  attributes_table do
    rows :name
    rows :expiration_time
    rows :measurement_unit
  end
end

form do |f|
  f.inputs "Detalle de tipo de producto" do
    f.input :name
    f.input :expiration_time
    f.input :measurement_unit
  end
  f.actions
end

end
