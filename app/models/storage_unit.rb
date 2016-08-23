class StorageUnit < ActiveRecord::Base
  validates :name, :email, :telephone, :address, :latitude, :longitude, presence: true
end
