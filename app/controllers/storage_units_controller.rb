class StorageUnitsController < ApplicationController
  def index
    @storage_units = StorageUnit.all unless current_user && current_user.manager
    @storage_units = current_user.storage_units if current_user && current_user.manager
    # TODO: Filter by product type (if storage unit inventory contains product)
    # TODO: Filter by location
  end

  def edit
    @storage_unit = StorageUnit.find(params[:id])
    redirect_to root_path unless current_user.storage_units.include?(@storage_unit)
  end

  def list
    @storage_units = StorageUnit.all
    render json: @storage_units
  end

  def new
    return redirect_to root_path if !current_user
    @storage_unit = StorageUnit.new
  end

  def create
    storage_unit = StorageUnit.create!(storage_unit_params.merge(managers: [current_user]))
    redirect_to storage_unit_path(storage_unit.id)
  end

  def show
    @storage_unit = StorageUnit.find(params[:id])
    @products = @storage_unit.products
    @products = @products.uniq
    @donations = @storage_unit.donations
    @available_products = @storage_unit.products.unexpired
  end

  def update
    @storage_unit = StorageUnit.find(params[:id])
    if @storage_unit.update_attributes(storage_unit_params)
      redirect_to storage_units_path
    else
      render 'edit'
    end
  end

  def favorites
    return redirect_to storage_units_path unless current_user.present?
    @storage_units = current_user.favorite_storage_units
  end

  def favorite
    storage_unit = StorageUnit.find(params[:id])
    if current_user.present? && !current_user.favorite_storage_unit?(storage_unit)
      add_to_favorites(storage_unit)
    end
    redirect_to storage_units_path
  end

  def unfavorite
    storage_unit = StorageUnit.find(params[:id])
    if current_user.present? && current_user.favorite_storage_unit?(storage_unit)
      remove_from_favorites(storage_unit)
    end
    redirect_to storage_units_path
  end

  def product_types
    storage_unit = StorageUnit.find(params[:id])
    product_type_ids = storage_unit.products.available.pluck(:product_type_id)
    render json: ProductType.where(id: product_type_ids), each_serializer: ProductTypeSerializer
  end

  def inventory
    storage_unit = StorageUnit.find(params[:id])
    products = storage_unit.products.available
    render json: products, each_serializer: ProductSerializer
  end

  private

  def storage_unit_params
    params.require(:storage_unit).permit(:name, :email, :telephone, :address, :latitude, :longitude, :service_time_from, :service_time_to)
  end

  def add_to_favorites(storage_unit)
    current_user.update_attributes!(
      favorite_storage_units: current_user.favorite_storage_units << storage_unit
    )
  end

  def remove_from_favorites(storage_unit)
    current_user.favorite_storage_units.delete(storage_unit)
    current_user.save!
  end
end
