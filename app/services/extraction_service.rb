class ExtractionService
  attr_reader :extraction_products, :storage_unit

  def initialize(storage_unit, extraction_products)
    @extraction_products = extraction_products
    @storage_unit = storage_unit
  end

  def extract_from_storage_unit
    extraction_products.find_each do |extraction_product|
      remove_from_inventory(extraction_product)
    end
  end

  def remove_from_inventory(extraction_product)
    inventory_units = storage_unit.products.where(product_type_id: extraction_product.product_type_id).order('expiration_date asc')
    required = extraction_product.required_quantity
    inventory_units.each do |inventory_unit|
      to_remove = (required > inventory_unit.quantity) ? inventory_unit.quantity : required
      open_date = inventory_unit.opened ? inventory_unit.open_date : Time.zone.today
      inventory_unit.update_attributes!(
        quantity: inventory_unit.quantity - to_remove, opened: true, open_date: open_date
      )
      required -= to_remove
    end
    extraction_product.update_attributes!(received_quantity: extraction_product.required_quantity - required)
  end

  def inventory_units(extraction_product)
    storage_unit.products.where(product_type: extraction_product.product_type)
                .unexpired.order('expiration_date ASC')
  end
end
