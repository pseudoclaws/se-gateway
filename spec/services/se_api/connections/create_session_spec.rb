# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Connections::CreateSession do
  let(:request) { spy call: response }
  let(:response) { spy status:, body: }

  let(:service) { described_class.new(request:) }

  subject { service.call(user) }

  let(:user) { create :user, :with_customer }
  let(:expire) { Time.current.to_s }

  context 'when API is up' do
    let(:status) { 200 }
    let(:body) do
      {
        'data' => { 'connect_url' => 'CONNECT_URL', 'expires_at' => expire }
      }
    end

    it 'creates a connect session' do
      connect_session = subject
      expect(connect_session).to be
      expect(connect_session.connect_url).to eq 'CONNECT_URL'
      expect(connect_session.expires_at).to eq Time.parse(expire)
    end
  end

  context 'when API is down' do
    let(:request) { ->(*) { raise Faraday::ConnectionFailed }  }

    it 'creates a connect session' do
      expect { subject }.to raise_error Faraday::ConnectionFailed
    end
  end
end
