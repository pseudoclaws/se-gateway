# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Connections::List do
  let(:service) { described_class.new(list_entities:) }
  let(:list_entities) { spy call: true }
  let(:user) { create :user, :with_customer }

  subject { service.call(user) }

  before { subject }

  it 'lists accounts' do
    expect(list_entities).to have_received(:call).with(
      api_path: '/api/v5/connections',
      data_record: user.customer,
      data_table: Connection,
      upsert_attributes: [
        :next_refresh_possible_at, :status, :categorization,
        :daily_refresh, :last_success_at, :show_consent_confirmation,
        :last_consent_id, :last_attempt
      ],
      query_params: { customer_id: user.customer.external_id },
    )
  end
end
