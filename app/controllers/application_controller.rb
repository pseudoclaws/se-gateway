# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class GatewayApiException < StandardError
    attr_reader :response_code

    def initialize(msg = "Gateway API Error", response_code = 400)
      @response_code = response_code
      super(msg)
    end
  end

  protect_from_forgery with: :null_session, if: -> { request.format.json? }

  wrap_parameters false

  rescue_from ActiveRecord::RecordNotFound do |_|
    render json: { errors: ['Record not found'] }, status: :not_found
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :first_name, :last_name])
  end
end
