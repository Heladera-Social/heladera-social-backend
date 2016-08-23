class Donation < ActiveRecord::Base
  validates :user, :storage_unit, presence: true

  has_many :products

  belongs_to :user
  belongs_to :storage_unit
end
