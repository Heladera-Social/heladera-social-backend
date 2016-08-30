class StorageUnitsController < ApplicationController
  def index
    @storage_units = StorageUnit.all
    # TODO: Filter by product type (if storage unit inventory contains product)
    # TODO: Filter by location
  end

  def show
    @storage_unit = StorageUnit.find(params[:id])
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

  private

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
