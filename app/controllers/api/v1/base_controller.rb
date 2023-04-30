# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken

      rescue_from ApplicationController::GatewayApiException do |e|
        render json: { errors: [e.message] }, status: e.response_code
      end

      rescue_from Faraday::ConnectionFailed do |_|
        render json: { errors: 'Connection to Gateway API failed' }, status: :bad_gateway
      end

      before_action :authenticate_user!
    end
  end
end
