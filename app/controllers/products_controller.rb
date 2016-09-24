class ProductsController < ApplicationController

  def index
    @products = Product.where.not(product_id: nil)
    @products = @products.where(product_type: product_type) if product_type.present?
    @products = @products.where(expiration_date: expiration_date) if expiration_date.present?
    @products_types = ProductType.all
  end

  private

  def product_type
    params[:product_type]
  end

  def expiration_date
    params[:expiration_date]
  end
end
