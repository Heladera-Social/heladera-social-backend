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
    inventory_unit = storage_unit.products.find(extraction_product.product_id)
    to_remove = extraction_product.quantity
    raise 'Invalid quantity' if to_remove > inventory_unit.quantity
    open_date = inventory_unit.opened ? inventory_unit.open_date : Time.zone.today
    inventory_unit.update_attributes!(
      quantity: inventory_unit.quantity - to_remove, opened: true, open_date: open_date
    )
  end

  def inventory_units(extraction_product)
    storage_unit.products.where(product_type: extraction_product.product_type)
                .unexpired.order('expiration_date ASC')
  end
end
