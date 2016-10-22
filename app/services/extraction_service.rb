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
    received = 0
    inventory_units(extraction_product).find_each do |inventory_unit|
      break if received == extraction_product.required_quantity
      required = extraction_product.required_quantity - received
      to_remove = required > inventory_unit.quantity ? inventory_unit.quantity : required
      inventory_unit.update_attributes!(quantity: inventory_unit.quantity - to_remove)
      received += to_remove
    end
    extraction_product.update_attributes!(received_quantity: received)
  end

  def inventory_units(extraction_product)
    storage_unit.products.where(product_type: extraction_product.product_type)
                .unexpired.order('expiration_date ASC')
  end
end
