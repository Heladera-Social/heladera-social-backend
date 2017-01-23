# frozen_string_literal: true
module V1
  class BaseController < ApplicationController
    respond_to :json

    protect_from_forgery with: :null_session

    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    rescue_from(ActionController::ParameterMissing) do |exception|
      bad_request([I18n.t('errors.parameter_missing', param: exception.param)])
    end

    rescue_from(ActiveRecord::RecordInvalid) do |exception|
      bad_request([exception])
    end

    protected

    def unauthorized(errors)
      render_errors(errors, :unauthorized)
    end

    def bad_request(errors)
      render_errors(errors, :bad_request)
    end

    def not_found
      head :not_found
    end

    def render_errors(errors, status)
      render json: { errors: errors }, status: status
    end
  end
end
