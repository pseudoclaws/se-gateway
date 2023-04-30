# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Connections::Refresh do
  let(:request) { spy call: response }
  let(:response) { spy status:, body: }

  let!(:connection) { create :connection }
  let(:service) { described_class.new(request:) }
  subject { service.call(connection, reconnect) }

  let(:reconnect) { false }

  context 'when API is up' do
    let(:status) { 200 }
    let(:body) do
      {
        'data' => { **connection.attributes, 'id' => 'EXTERNAL_ID', 'customer_id' => 'CUSTOMER_ID' }
      }
    end

    context 'with reconnect' do
      let(:reconnect) { true }
      it 'creates a connect session' do
        expect(subject).to be
      end
    end

    context 'with refresh' do
      let(:reconnect) { false }
      it 'creates a connect session' do
        expect(subject).to be
      end
    end
  end

  context 'when API is down' do
    let(:request) { ->(*) { raise Faraday::ConnectionFailed }  }

    it 'creates a connect session' do
      expect { subject }.to raise_error Faraday::ConnectionFailed
    end
  end
end
