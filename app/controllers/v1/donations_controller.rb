# frozen_string_literal: true
module V1
  class DonationsController < V1::BaseController
    
    def create
      donation = Donation.create!(donation_params)
      render json: { donatio: donation }, status: 200
    end

    def donation_params
    	params.require(:donation).permit(:storage_unit_id, :name, :last_name, :telephone, :delivered, donation_products_attributes: [:label, :product_type_id, :quantity, :expiration_date])
  	end
  end
end
