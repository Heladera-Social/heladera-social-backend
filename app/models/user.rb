class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations

  has_and_belongs_to_many :storage_units, join_table: :storage_unit_managers

  has_and_belongs_to_many :favorite_storage_units, class_name: 'StorageUnit',
                                                   join_table: :fav_storage_units

  def full_name
    "#{name} #{last_name}"
  end

  def favorite_storage_unit?(storage_unit)
    favorite_storage_units.include?(storage_unit)
  end
end
