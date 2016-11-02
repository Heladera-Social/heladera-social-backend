class ProductsController < ApplicationController

  def index
    @storage_units = current_user.storage_units.all
    @products = params[:expired] ? Product.expired : Product.unexpired
    @products = Product.expires_in(params[:days].to_i) if params[:days].present?
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
