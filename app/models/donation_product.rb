class DonationProduct < ActiveRecord::Base
  include PgSearch

  HALF_CODE_LENGTH = 3 

  validates :product_type, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  belongs_to :product_type
  belongs_to :donation

  delegate :name, to: :product_type
  delegate :measurement_unit, to: :product_type

  before_create :generate_code

  def generate_code
    self.code = SecureRandom.hex(HALF_CODE_LENGTH) unless self.code.present?
  end
end
