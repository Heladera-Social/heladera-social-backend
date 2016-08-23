ActiveAdmin.register User do

permit_params :email, :name, :last_name, :password, :password_confirmation

index do
  id_column
  column :email
  column :name
  column :last_name
  actions
end

show do
  attributes_table do
    rows :id
    rows :email
    rows :name
    rows :last_name
    rows :telephone
  end
end

filter :email
filter :name
filter :last_name

form do |f|
  f.inputs "Detalle de Usuario" do
    f.input :email
    f.input :name
    f.input :last_name
    f.input :telephone
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

end
