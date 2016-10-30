class Donation < ActiveRecord::Base
  validates :user, :storage_unit, :donation_products, presence: true

  has_many :products
  has_many :donation_products

  belongs_to :user
  belongs_to :storage_unit
  accepts_nested_attributes_for :donation_products, allow_destroy: true
  after_create :add_to_storage_unit

  def add_to_storage_unit
    donation_products.find_each do |product|
      storage_unit.add_to_inventory(product)
    end
  end
end
