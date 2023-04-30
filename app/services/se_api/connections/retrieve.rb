# frozen_string_literal: true

module SeApi
  module Connections
    class Retrieve < SeApi::Connections::Base
      include AutoInject[
        list_accounts: 'se_api.accounts.list',
        list_transactions: 'se_api.transactions.list',
        request: 'se_api.request'
      ]

      def call(customer, connection_id)
        connection = customer.connections.find_or_initialize_by(external_id: connection_id)
        if connection.persisted?
          import_connection_data!(connection)
        else
          create_connection!(connection)
        end
        connection
      end

      private

      def create_connection!(connection)
        response = request.call(:get, "#{API_PATH}/#{connection.external_id}")
        check_response_status!(response)
        process_data!(connection, response.body['data'])
      end

      def process_data!(connection, data)
        ActiveRecord::Base.transaction do
          connection.update!(
            **data.slice(
              *Connection.attribute_names.reject { |name| name.in? %w[id customer_id] }
            )
          )
          import_connection_data!(connection)
        end
      end

      def import_connection_data!(connection)
        list_accounts.call(connection)

        connection.accounts.each do |account|
          list_transactions.call(account)
        end
      end
    end
  end
end
