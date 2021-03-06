class Product < ActiveRecord::Base
  paginates_per 1
  validates :product_type, presence: true
  belongs_to :product_type

  belongs_to :donation

  belongs_to :storage_unit

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type

  scope :expired, -> { where('expiration_date < ? OR expiration_date IS NULL', Time.zone.today) }
  scope :unexpired, -> { where('expiration_date >= ? OR expiration_date IS NULL', Time.zone.today) }
  scope :available, -> { where('quantity > 0').unexpired }
  scope :expires_in, ->(days) { where('expiration_date <= ? AND expiration_date >= ? OR expiration_date IS NULL', Time.zone.today + days.days, Time.zone.today) }
end
