class StorageUnit < ActiveRecord::Base
  validates :name, :email, :telephone, :address, :latitude, :longitude, presence: true

  has_and_belongs_to_many :managers, class_name: 'User', join_table: :storage_unit_managers

  has_and_belongs_to_many :favorited_users, class_name: 'User', join_table: :fav_storage_units

  has_many :donations
  has_many :extractions

  accepts_nested_attributes_for :managers

  has_many :products

  def add_to_inventory(product)
    inventory_unit = products.find_or_create_by!(
      product_type: product.product_type,
      expiration_date: product.expiration_date,
      label: product.label,
      code: product.code
    )
    inventory_unit.update_attributes!(quantity: (inventory_unit.quantity || 0) + product.quantity)
  end
end
