# frozen_string_literal: true
module V1
  class ProductTypesController < V1::BaseController
    def index
      render json: ProductType.all
    end
  end
end
