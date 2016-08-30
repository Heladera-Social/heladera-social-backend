class StorageUnit < ActiveRecord::Base
  validates :name, :email, :telephone, :address, :latitude, :longitude, presence: true

  has_and_belongs_to_many :managers, class_name: 'User', join_table: :storage_unit_managers

  has_and_belongs_to_many :favorited_users, class_name: 'User', join_table: :fav_storage_units

  has_many :donations

  has_many :products
end
