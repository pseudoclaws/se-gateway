# frozen_string_literal: true

require 'rails_helper'

describe CustomerJob do
  let(:user) { create :user }
  let(:job) { described_class.new }
  let(:create_customer) { spy :create_customer }
  subject { job.perform(user.id) }

  before do
    allow_any_instance_of(described_class).to receive(:create_customer).and_return(create_customer)
  end

  it 'creates customer' do
    subject
    expect(create_customer).to have_received(:call).with(user)
  end

  context 'with failed gateway' do
    let(:create_customer) do
      lambda do |_|
        raise ApplicationController::GatewayApiException
                .new('Something went wrong', 400)
      end
    end

    it 'raises error' do
      expect { subject }.to raise_error ApplicationController::GatewayApiException
    end
  end

  context 'with failed http' do
    let(:create_customer) do
      lambda do |_|
        raise Faraday::ConnectionFailed
      end
    end

    it 'raises error' do
      expect { subject }.to raise_error Faraday::ConnectionFailed
    end
  end
end
