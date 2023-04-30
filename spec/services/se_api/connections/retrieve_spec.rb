# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Connections::Retrieve do
  let(:request) { spy call: response }
  let(:response) { spy status:, body: }

  let(:service) { described_class.new(list_accounts:, list_transactions:, request:) }
  let(:user) { create :user, :with_customer }
  let(:list_accounts) { spy call: true }
  let(:list_transactions) { spy call: true }
  subject { service.call(user.customer, connection.external_id) }

  context 'when API is up' do
    let(:status) { 200 }
    let(:body) do
      {
        'data' => { **connection.attributes, 'id' => 'EXTERNAL_ID', 'customer_id' => 'CUSTOMER_ID' }
      }
    end

    context 'with existing connection' do
      let!(:connection) { create :connection, customer: user.customer }
      let!(:account) { create :account, connection:}

      before { subject }

      it 'updates the connection' do
        expect(subject).to be_persisted
        expect(list_accounts).to have_received(:call).with(connection)
        expect(list_transactions).to have_received(:call).with(account)
      end
    end

    context 'with new connection' do
      let(:connection) { build :connection, customer: user.customer }
      before { subject }
      it 'creates the connection' do
        expect(subject).to be_persisted
      end
    end
  end

  context 'when API is down' do
    let(:connection) { build :connection, customer: user.customer }

    let(:request) { ->(*) { raise Faraday::ConnectionFailed }  }

    it 'creates a connect session' do
      expect { subject }.to raise_error Faraday::ConnectionFailed
    end
  end
end
