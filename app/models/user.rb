class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :donations

  has_and_belongs_to_many :storage_units, join_table: :storage_unit_managers

  def full_name
    name + last_name
  end
end
