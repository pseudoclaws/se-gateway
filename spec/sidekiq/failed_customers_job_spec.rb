# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FailedCustomersJob, type: :job do
  let!(:user) { create :user, customer_state: :failed }
  let(:job) { described_class.new }
  subject { job.perform }

  before do
    allow(CustomerJob).to receive(:perform_async)
  end

  it 'schedules customer for update' do
    subject
    expect(CustomerJob).to have_received(:perform_async).with(user.id)
  end
end
