class DonationsController < ApplicationController

  def show
    @donation = Donation.find(params[:id])
  end

  def new
    return redirect_to root_path if !current_user
    @storage_units = current_user.storage_units if current_user && current_user.manager
    @product_types = ProductType.all
    @donation = Donation.new
  end

  def create
    donation = Donation.create!(donation_params)
    redirect_to donation_path(donation.id)
  rescue => e
    redirect_to new_donation_path, flash: { error: 'Necesitás ingresar al menos un producto.' }
  end

  def confirm_delivery
    donation = Donation.find(params[:id])
    donation.update_attributes!(delivered: true)
    redirect_to storage_unit_path(donation.storage_unit_id)
  end

  private

  def donation_params
    params.require(:donation).permit(:storage_unit_id, :name, :last_name, :telephone, :delivered, donation_products_attributes: [:label, :product_type_id, :quantity, :expiration_date])
  end
end
