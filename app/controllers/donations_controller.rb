class DonationsController < ApplicationController

  def show
    @donation = Donation.find(params[:id])
  end
  
  def new
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
