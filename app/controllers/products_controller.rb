class ProductsController < ApplicationController

  def index
    @storage_units = current_user.storage_units.all
    @products = current_user.products
    @products = params[:expired] ? @products.expired : @products.unexpired
    @products = @products.expires_in(params[:days].to_i) if params[:days].present?
    @products = @products.where(product_type: product_type) if product_type.present?
    @products = @products.joins(:product_type)
    @products = @products.order("#{params[:order]} #{params[:direction] || :asc}") if params[:order].present?
    @products = @products.page(params[:page]).per(10)
    @products_types = ProductType.where(id: @products.pluck(:product_type_id))
  end

  private

  def product_type
    params[:product_type]
  end

  def expiration_date
    params[:expiration_date]
  end
end
