# frozen_string_literal: true

RSpec.shared_context :faraday_stubs do
  let(:stubs)  { Faraday::Adapter::Test::Stubs.new }
  let(:conn) do
    Faraday.new do |b|
      b.request :json # encode req bodies as JSON and automatically set the Content-Type header
      b.response :json # decode response bodies as JSON
      b.adapter(:test, stubs)
    end
  end
  let(:get_connection) { spy call: conn }
end

