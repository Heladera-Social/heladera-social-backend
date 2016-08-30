class StorageUnitsController < ApplicationController
  # Map
  def index
    @storage_units = StorageUnit.all
    # TODO: Filter by product type (if storage unit inventory contains product)
    # TODO: Filter by location
  end

  def show
    @storage_unit = StorageUnit.find(params[:id])
  end

  def favorites
    @storage_units = current_user.favorite_storage_units
  end
end
