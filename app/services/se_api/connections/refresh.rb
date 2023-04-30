# frozen_string_literal: true

module SeApi
  module Connections
    class Refresh < SeApi::Connections::Base
      include AutoInject[
        request: 'se_api.request'
      ]

      def call(connection, reconnect = false)
        response = request.call(
          :put,
          request_path(connection, reconnect),
          request_data(reconnect)
        )
        check_response_status!(response)
        update_connection!(connection, response.body['data'])
      end
      
      private

      def update_connection!(connection, data)
        connection.update!(
          **data.slice(*Connection.attribute_names.reject { |name| name.in? %w[id customer_id] })
        )
      end

      def request_path(connection, reconnect)
        [API_PATH, connection.external_id, reconnect ? 'reconnect' : 'refresh'].join('/')
      end
      
      def request_data(reconnect)
        if reconnect
          {
            data: {
              credentials: {
                login: 'username',
                password: 'secret'
              },
              consent: {
                scopes: [
                  'account_details'
                ]
              },
              override_credentials: true
            }
          }
        else
          {
            data: {
              attempt: {
                fetch_scopes: %w[accounts transactions]
              }
            }
          }
        end
      end
    end
  end
end
