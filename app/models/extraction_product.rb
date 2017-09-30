class ExtractionProduct < ActiveRecord::Base
  validates :product_type, :required_quantity, presence: true
  validates :required_quantity, numericality: { greater_than: 0 }

  belongs_to :extraction
  belongs_to :product_type

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type
end
