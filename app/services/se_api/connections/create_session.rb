# frozen_string_literal: true

module SeApi
  module Connections
    class CreateSession < SeApi::Base
      include AutoInject[
        request: 'se_api.request'
      ]

      API_PATH = '/api/v5/connect_sessions/create'

      def call(user)
        payload = payload(user.customer)
        response = request.call(:post, API_PATH, payload)
        return unless response.status.in? [200, 201]

        ConnectionSession.create!(
          customer: user.customer,
          **response.body['data'].slice('connect_url', 'expires_at')
        )
      end

      private

      def payload(customer)
        {
          data: {
            customer_id: customer.external_id,
            consent: {
              scopes: %w[account_details transactions_details],
              from_date: customer.created_at
            },
            attempt: {
              return_to: APP_HOST
            }
          }
        }
      end
    end
  end
end
