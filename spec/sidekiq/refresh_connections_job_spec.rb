# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RefreshConnectionsJob, type: :job do
  let!(:connection) { create :connection }
  let(:job) { described_class.new }
  subject { job.perform }

  before do
    allow(RefreshConnectionJob).to receive(:perform_async)
  end

  it 'schedules customer for update' do
    subject
    expect(RefreshConnectionJob).to have_received(:perform_async).with(connection.id)
  end
end
