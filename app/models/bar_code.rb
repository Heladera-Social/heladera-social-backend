class BarCode < ActiveRecord::Base
  validates :code, :amount, presence: true

  belongs_to :product_type

end
