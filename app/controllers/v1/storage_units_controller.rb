# frozen_string_literal: true
module V1
  class StorageUnitsController < V1::BaseController
    def index
      render json: StorageUnit.all
    end
  end
end
