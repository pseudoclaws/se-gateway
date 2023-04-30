# frozen_string_literal: true

module SeApi
  class Base
    protected

    def check_response_status!(response)
      return if response.status == 200

      raise ApplicationController::GatewayApiException.new(
        response.body.dig('error', 'message'),
        response.status
      )
    end
  end
end
