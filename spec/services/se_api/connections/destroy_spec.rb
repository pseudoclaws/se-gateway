# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Connections::Destroy do
  let(:request) { spy call: response }
  let(:response) { spy status:, body: }

  let!(:connection) { create :connection }
  let(:service) { described_class.new(request:) }
  subject { service.call(connection) }


  context 'when API is up' do
    shared_examples :connection_destroyer do
      it 'destroys the connection' do
        expect(subject).to be
      end
    end

    let(:body) do
      {
        'data' => { 'removed' => true }
      }
    end

    context 'when response is 200' do
      let(:status) { 200 }
      it_behaves_like :connection_destroyer
    end

    context 'when response is 404' do
      let(:status) { 404 }
      it_behaves_like :connection_destroyer
    end

    context 'when response is 400' do
      let(:status) { 400 }
      it 'destroys the connection' do
        expect { subject }.to raise_error ApplicationController::GatewayApiException
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
