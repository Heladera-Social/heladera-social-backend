class ExtractionsController < ApplicationController

  def show
    @extraction = Extraction.find(params[:id])
  end
  
  def new
    @extraction = Extraction.new
  end

  def create
    Extraction.create!(extraction_params.merge(user: current_user))
    render 'show'
  end

  private

  def extraction_params
    params.require(:extraction).permit(
      :storage_unit_id,
      extraction_products_attributes: [:product_type_id, :required_quantity]
    )
  end
end
