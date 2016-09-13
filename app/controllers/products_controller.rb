class ProductsController < ApplicationController

  def index
    @products = []
    current_user.storage_units.each do |s|
      s.products.each do |p|
        @products << p
      end
    end
    @products = @products.uniq
  end
  
end