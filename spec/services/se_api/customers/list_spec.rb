# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Customers::List do
  let(:service) { described_class.new(list_entities:) }
  let(:list_entities) { spy call: true }
  let(:user) { create :user, :with_customer }

  subject { service.call(user) }

  before { subject }

  it 'lists accounts' do
    expect(list_entities).to have_received(:call).with(
      api_path: '/api/v5/customers',
      data_record: user,
      data_table: Customer,
      upsert_attributes: [:secret, :updated_at],
      query_params: { identifier: user.email }
    )
  end
end
