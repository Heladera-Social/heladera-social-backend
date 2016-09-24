class ProductType < ActiveRecord::Base
  validates :name, :measurement_unit, presence: true
  has_many :products
  has_many :extraction_products
end
