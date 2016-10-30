class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end

  def create
    contact = Contact.create!(extraction_params)
    redirect_to new_contact_path
  end

  private

  def extraction_params
    params.require(:contact).permit(:email, :first_name, :last_name, :telephone)
  end
end
