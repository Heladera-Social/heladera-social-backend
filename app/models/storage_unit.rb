class StorageUnit < ActiveRecord::Base
  paginates_per 5
  validates :name, :email, :telephone, :address, :latitude, :longitude, presence: true

  has_and_belongs_to_many :managers, class_name: 'User', join_table: :storage_unit_managers

  has_and_belongs_to_many :favorited_users, class_name: 'User', join_table: :fav_storage_units

  has_many :donations
  has_many :extractions

  accepts_nested_attributes_for :managers

  has_many :products

  scope :with_available_products, -> { where(id: Product.available.pluck(:storage_unit_id)) }

  def add_to_inventory(product)
    Product.create!(
      product_type: product.product_type,
      expiration_date: product.expiration_date,
      label: product.label,
      code: product.code,
      quantity: product.quantity,
      storage_unit: self
    )
  end
end
