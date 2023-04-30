# frozen_string_literal: true

module SeApi
  module Connections
    class Destroy < SeApi::Connections::Base
      include AutoInject[
        request: 'se_api.request'
      ]

      def call(connection)
        response = request.call(:delete, "#{API_PATH}/#{connection.external_id}")
        removed = check_removed(response)
        connection.destroy! if removed
        removed
      end

      private

      def check_removed(response)
        case response.status
        when 404
          true
        when 200
          response.body.dig('data', 'removed')
        else
          check_response_status!(response)
        end
      end
    end
  end
end
