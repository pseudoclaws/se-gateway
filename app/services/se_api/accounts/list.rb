# frozen_string_literal: true

module SeApi
  module Accounts
    class List < SeApi::Base
      include AutoInject[
        list_entities: 'se_api.list_entities',
      ]

      API_PATH = '/api/v5/accounts'

      def call(connection)
        list_entities.call(
          api_path: API_PATH,
          data_record: connection,
          data_table: Account,
          upsert_attributes:,
          query_params: { connection_id: connection.external_id }
        )
      end

      private

      def upsert_attributes
        [:balance, :updated_at, :extra]
      end
    end
  end
end
