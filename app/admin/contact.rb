ActiveAdmin.register Contact do

permit_params :email, :firs_name, :last_name, :telephone

index do
  selectable_column
  id_column
  column :name
  column :first_name
  column :last_name
  column :telephone
  actions
end

filter :email

end