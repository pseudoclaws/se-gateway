# frozen_string_literal: true

require 'rails_helper'

describe SeApi::Request do
  let(:service) { described_class.new(get_connection:) }
  let(:get_connection) { spy call: faraday_stub }
  let(:faraday_stub) { spy put: true, post: true, get: true, delete: true }
  let(:method) { :unknown }
  subject { service.call(method, '/path', { request: :data }) }

  it 'raises an error' do
    expect { subject }.to raise_error ArgumentError
  end

  shared_examples :request do
    before { subject }
    it 'calls the method' do
      expect(faraday_stub).to have_received(method).with(
        '/path',
        { request: :data },
        'App-id' => nil,
        'Secret' => nil
      )
    end
  end

  context ':put' do
    let(:method) { :put }
    it_behaves_like :request
  end

  context ':post' do
    let(:method) { :post }
    it_behaves_like :request
  end

  context ':get' do
    let(:method) { :get }
    it_behaves_like :request
  end

  context ':delete' do
    let(:method) { :delete }
    it_behaves_like :request
  end
end
