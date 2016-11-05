class ExtractionProduct < ActiveRecord::Base
  validates :product, :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :extraction
  belongs_to :product

  delegate :name, to: :product
  delegate :label, to: :product
  delegate :measurement_unit, to: :product
end
