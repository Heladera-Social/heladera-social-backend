class Product < ActiveRecord::Base
  include PgSearch

  HALF_CODE_LENGTH = 3 

  validates :product_type, presence: true
  belongs_to :product_type

  belongs_to :donation

  belongs_to :storage_unit

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type

  before_create :generate_code

  scope :unexpired, -> { where('expiration_date >= ? OR expiration_date IS NULL', Time.zone.today) }
  scope :available, -> { where('quantity > 0').unexpired }
  scope :inventory, -> { where.not(storage_unit_id: nil) }

  def generate_code
    self.code = SecureRandom.hex(HALF_CODE_LENGTH) unless self.code.present?
  end
end
