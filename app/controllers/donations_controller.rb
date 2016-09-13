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
    Donation.create!(donation_params.merge(user: current_user))
    render 'show'
  end

  private

  def donation_params
    params.require(:donation).permit(:storage_unit_id, products_attributes: [:product_type_id, :quantity, :expiration_date])
  end
end
