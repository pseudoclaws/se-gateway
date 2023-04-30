# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Customers::Create do
  let(:request) { spy call: response }
  let(:response) { spy status:, body: }

  let!(:user) { create :user, customer: nil }
  let(:service) { described_class.new(list_customer:, request:) }
  let(:list_customer) { spy call: true }
  subject { service.call(user) }

  before do
    user.run!
  end


  context 'when API is up' do
    let(:customer) { build :customer }
    let(:status) { 200 }
    let(:body) do
      {
        'data' => { **customer.attributes, 'id' => 'EXTERNAL_ID' }
      }
    end
    context 'with 200 response' do
      it 'creates the customer' do
        customer = subject
        expect(customer).to be_persisted
      end
    end

    context 'with 409 api response' do
      let(:list_customer) { spy call: create(:customer, user:) }
      let(:status) { 409 }
      let(:body) do
        {
          'error' => { 'message' => 'Customer is already activated' }
        }
      end

      it 'creates the customer' do
        customer = subject
        expect(customer).to be_persisted
      end
    end

    context 'with 400 api response' do
      let(:status) { 400 }
      let(:body) do
        {
          'error' => { 'message' => 'Customer is already activated' }
        }
      end

      it 'raises error' do
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
