# frozen_string_literal: true

module SeApi
  class ListEntities < SeApi::Base
    include AutoInject[
      request: 'se_api.request',
      prepare_data: 'se_api.prepare_data'
    ]

    def call(
      api_path:,
      query_params:,
      data_record:,
      data_table:,
      upsert_attributes:,
      fk_field: "#{data_record.class.name.singularize.downcase}_id"
    )
      response = request.call(:get, api_path, query_params)
      check_response_status!(response)
      import_data!(data_record, data_table, response.body['data'], fk_field, upsert_attributes)
    end

    private

    def import_data!(data_record, data_table, raw_data, fk_field, upsert_attributes)
      data_table.import!(
        prepare_data.call(raw_data, data_table.attribute_names, fk_field => data_record.id),
        on_duplicate_key_update: {
          conflict_target: [:external_id],
          columns: upsert_attributes
        }
      )
    end
  end
end
