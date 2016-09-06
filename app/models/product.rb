class Product < ActiveRecord::Base
  validates :product_type, :quantity, presence: true
  belongs_to :product_type

  belongs_to :donation

  belongs_to :storage_unit

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type

  scope :unexpired, -> { where('expiration_date > ? OR expiration_date IS NULL', Time.zone.now) }
end
