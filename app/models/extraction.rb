class Extraction < ActiveRecord::Base
  validates :user, :storage_unit, :extraction_products, presence: true

  has_many :extraction_products

  belongs_to :user
  belongs_to :storage_unit
  accepts_nested_attributes_for :extraction_products, allow_destroy: true
  after_create :remove_from_storage_unit

  def remove_from_storage_unit
    ExtractionService.new(storage_unit, extraction_products).extract_from_storage_unit
  end
end
