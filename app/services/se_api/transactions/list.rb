# frozen_string_literal: true

module SeApi
  module Transactions
    class List
      include AutoInject[
        list_entities: 'se_api.list_entities',
      ]

      API_PATH = '/api/v5/transactions'

      def call(account)
        list_entities.call(
          api_path: API_PATH,
          data_record: account,
          data_table: Transaction,
          upsert_attributes:,
          query_params: {
            connection_id: account.connection.external_id,
            account_id: account.external_id
          }
        )
        list_entities.call(
          api_path: "#{API_PATH}/pending",
          data_record: account,
          data_table: Transaction,
          upsert_attributes:,
          query_params: {
            connection_id: account.connection.external_id,
            account_id: account.external_id
          }
        )
      end

      private

      def upsert_attributes
        [:mode, :status, :amount, :description, :category, :updated_at, :extra]
      end
    end
  end
end
