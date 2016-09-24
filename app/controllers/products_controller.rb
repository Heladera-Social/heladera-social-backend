class ProductsController < ApplicationController

  def index
  	@products = Product.where(product_type: params[:product_type]).uniq if params[:product_type].present?
    @products = Product.all.uniq unless params[:product_type].present?
    @products_types = ProductType.all
  end
  
end