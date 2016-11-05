class ProductSerializer < ActiveModel::Serializer
  attributes :id, :measurement_unit, :quantity, :opened, :open_date, :expiration_date, :label, :name
end
