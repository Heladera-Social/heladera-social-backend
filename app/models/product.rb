class Product < ActiveRecord::Base
  validates :product_type, :quantity, presence: true
  belongs_to :product_type

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type
end
