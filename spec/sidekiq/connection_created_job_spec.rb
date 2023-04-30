# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ConnectionCreatedJob, type: :job do
  let(:customer) { create :customer }
  let(:connection) { create :connection, customer: }
  let(:create_connection) { spy call: true }

  before do
    allow_any_instance_of(described_class).to receive(:create_connection).and_return(create_connection)
    subject
  end

  subject { described_class.new.perform(customer.external_id, connection.external_id) }

  it 'creates the connection' do
    expect(create_connection).to have_received(:call).with(
      customer,
      connection.external_id
    )
  end
end
