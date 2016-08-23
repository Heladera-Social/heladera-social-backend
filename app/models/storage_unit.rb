class StorageUnit < ActiveRecord::Base
  validates :name, :email, :telephone, :address, :latitude, :longitude, presence: true

  has_many :donations
end
