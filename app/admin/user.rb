ActiveAdmin.register User do

index do
  selectable_column
  id_column
  column :email
  column :name
  column :last_name
  actions
end

filter :email
filter :name
filter :last_name

form do |f|
  f.inputs "Admin Details" do
    f.input :email
    f.input :name
    f.input :last_name
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

end
