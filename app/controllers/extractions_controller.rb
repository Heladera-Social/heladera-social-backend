 class ExtractionsController < ApplicationController
  EMPTY_EXTRACTION_PRODUCTS_ERROR_MSG = 'Extraction products no puede estar en blanco'.freeze

  def show
    @extraction = Extraction.find(params[:id])
  end

  def new
    return redirect_to root_path if !current_user
    @storage_units = current_user.storage_units.with_available_products if current_user.manager
    @product_types = ProductType.where(id: current_user.products.available.pluck(:product_type_id))
    @extraction = Extraction.new
  end

  def create
    extraction = Extraction.create!(extraction_params.merge(user: current_user))
    redirect_to extraction_path(extraction.id)
  rescue => e
    if e.message.include? EMPTY_EXTRACTION_PRODUCTS_ERROR_MSG
      redirect_to new_extraction_path, flash: { error: 'Necesitás extraer al menos un producto.' }
    else
      redirect_to new_extraction_path, flash: { error: 'Intentaste extraer más de lo posible para un producto. Recordá respetar los máximos posibles que se muestran.' }
    end
  end

  private

  def extraction_params
    params.require(:extraction).permit(
      :storage_unit_id,
      :name,
      :last_name,
      :telephone,
      extraction_products_attributes: [:product_id, :product_type_id, :required_quantity, :_destroy]
    )
  end
end
