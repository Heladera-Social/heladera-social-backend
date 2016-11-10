class BarCodeController < ApplicationController
  
  def get_product
    code = params[:code].to_i
    @barcode = BarCode.where(code: code).includes(:product_type)
    render json: [@barcode.first, @barcode.first.product_type]
  end 
end