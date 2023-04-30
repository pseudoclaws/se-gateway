# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Transactions::List do
  let(:service) { described_class.new(list_entities:) }
  let(:list_entities) { spy call: true }
  let(:account) { create :account, :with_connection }

  subject { service.call(account) }

  before { subject }

  it 'lists accounts' do
    expect(list_entities).to have_received(:call).with(
      api_path: '/api/v5/transactions',
      data_record: account,
      data_table: Transaction,
      upsert_attributes: [:mode, :status, :amount, :description, :category, :updated_at, :extra],
      query_params: {
        connection_id: account.connection.external_id,
        account_id: account.external_id
      }
    )
    expect(list_entities).to have_received(:call).with(
      api_path: '/api/v5/transactions/pending',
      data_record: account,
      data_table: Transaction,
      upsert_attributes: [:mode, :status, :amount, :description, :category, :updated_at, :extra],
      query_params: {
        connection_id: account.connection.external_id,
        account_id: account.external_id
      }
    )
  end
end
