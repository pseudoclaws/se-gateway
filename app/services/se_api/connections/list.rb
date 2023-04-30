# frozen_string_literal: true

module SeApi
  module Connections
    class List < SeApi::Connections::Base
      include AutoInject[
        list_entities: 'se_api.list_entities',
      ]

      def call(user)
        return if user.customer.blank?

        list_entities.call(
          api_path: API_PATH,
          data_record: user.customer,
          data_table: Connection,
          upsert_attributes:,
          query_params: { customer_id: user.customer.external_id },
        )
      end

      private

      def upsert_attributes
        [
          :next_refresh_possible_at, :status, :categorization,
          :daily_refresh, :last_success_at, :show_consent_confirmation,
          :last_consent_id, :last_attempt
        ]
      end
    end
  end
end
