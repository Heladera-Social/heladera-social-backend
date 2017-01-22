ActiveAdmin.register StorageUnit do

permit_params :name, :email, :telephone, :address, :latitude, :longitude, :service_time_from, :service_time_to, manager_ids: []

index do
  selectable_column
  id_column
  column :name
  column :email
  column :telephone
  actions
end


filter :name
filter :email
filter :telephone
filter :address
filter :latitude
filter :longitude
filter :service_time_from
filter :service_time_to

show do
  attributes_table do
    rows :email
    rows :name
    rows :address
    rows :telephone
    rows :latitude
    rows :longitude
    rows :managers
    rows :service_time_from
    rows :service_time_to
  end
end

form do |f|
  f.inputs "Detalle De Comedor" do
    f.input :email
    f.input :name
    f.input :address
    f.input :telephone
    f.input :latitude
    f.input :longitude
    f.input :service_time_from
    f.input :service_time_to
    f.input :managers, :as => :select, :input_html => {:multiple => true}
  end
  f.actions
end

end
