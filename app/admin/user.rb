ActiveAdmin.register User do

permit_params :email, :name, :last_name, :password, :password_confirmation, :telephone, :manager

controller do
  def update
    if params[:user][:password].blank?
      params[:user].delete('password')
      params[:user].delete('password_confirmation')
    end
    super
  end

end

index do
  id_column
  column :email
  column :name
  column :last_name
  column :manager
  actions
end

show do
  attributes_table do
    rows :id
    rows :email
    rows :name
    rows :last_name
    rows :telephone
    rows :manager
  end
end

filter :email
filter :name
filter :last_name
filter :manager

form do |f|
  f.inputs "Detalle de Usuario" do
    f.input :email
    f.input :name
    f.input :last_name
    f.input :telephone
    f.input :manager
    f.input :password
    f.input :password_confirmation
  end
  f.actions
end

end
