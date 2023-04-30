# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefreshConnectionJob, type: :job do
  let(:job) { described_class.new }
  let(:user) { create :user, :with_customer }
  let(:refresh_connection) { spy :refresh_connection, call: true }
  let(:connection) { create :connection, customer: user.customer }
  subject { job.perform(connection.id) }

  before do
    allow_any_instance_of(described_class)
      .to receive(:refresh_connection).and_return(refresh_connection)
  end

  it 'refreshes connection' do
    subject
    expect(refresh_connection).to have_received(:call).with(connection)
  end

  context 'with failed gateway' do
    let(:refresh_connection) do
      lambda do |_|
        raise ApplicationController::GatewayApiException
                .new('Something went wrong', 400)
      end
    end

    it 'skips error' do
      expect { subject }.not_to raise_error
    end
  end

  context 'with failed http' do
    let(:refresh_connection) do
      lambda do |_|
        raise Faraday::ConnectionFailed
      end
    end

    it 'skips error' do
      expect { subject }.not_to raise_error
    end
  end
end
