# frozen_string_literal: true

module SeApi
  module Customers
    class List
      include AutoInject[
        list_entities: 'se_api.list_entities',
      ]

      API_PATH = '/api/v5/customers'

      def call(user)
        return if user.finished?

        user.run! unless user.in_progress?
        list_customer!(user)
        user.finish!
        user.customer
      end

      private

      def list_customer!(user)
        begin
          list_entities.call(
            api_path: API_PATH,
            data_record: user,
            data_table: Customer,
            upsert_attributes:,
            query_params: { identifier: user.email }
          )
        rescue ApplicationController::GatewayApiException, Faraday::ConnectionFailed => e
          user.fail!
          raise e
        end
      end

      def upsert_attributes
        [:secret, :updated_at]
      end
    end
  end
end
