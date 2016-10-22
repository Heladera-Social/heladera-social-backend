class ExtractionsController < ApplicationController

  def show
    @extraction = Extraction.find(params[:id])
  end
  
  def new
    return redirect_to root_path if !current_user
    @storage_units = current_user.storage_units if current_user && current_user.manager
    @product_types = ProductType.all
    @extraction = Extraction.new
  end

  def create
    extraction = Extraction.create!(extraction_params.merge(user: current_user))
    redirect_to extraction_path(extraction.id)
  end

  private

  def extraction_params
    params.require(:extraction).permit(
      :storage_unit_id,
      :name, 
      :last_name, 
      :telephone,
      extraction_products_attributes: [:product_id, :quantity]
    )
  end
end
