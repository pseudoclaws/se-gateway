# frozen_string_literal: true

class SeApi::PrepareImportData
  def call(raw_data, attribute_names, reference)
    raw_data.map do |e|
      e.transform_keys! { |k| k == 'id' ? 'external_id' : k }
      e.slice(*attribute_names).merge(reference)
    end
  end
end
