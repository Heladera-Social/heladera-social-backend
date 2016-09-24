class ExtractionProduct < ActiveRecord::Base
  validates :product_type, :required_quantity, :received_quantity, presence: true
  belongs_to :product_type

  belongs_to :extraction

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type
end
