# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Accounts::List do
  let(:service) { described_class.new(list_entities:) }
  let(:list_entities) { spy call: true }
  let(:connection) { create :connection }

  subject { service.call(connection) }

  before { subject }

  it 'lists accounts' do
    expect(list_entities).to have_received(:call).with(
      api_path: '/api/v5/accounts',
      data_record: connection,
      data_table: Account,
      upsert_attributes: [:balance, :updated_at, :extra],
      query_params: { connection_id: connection.external_id }
    )
  end
end
