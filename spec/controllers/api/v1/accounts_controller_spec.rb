# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::AccountsController do
  describe 'GET #show' do
    let(:list_transactions) { spy :list_transactions, call: true }
    let(:user) { create :user, :with_customer }
    let(:connection) { create :connection, customer: user.customer }
    let(:account) { create :account, connection: connection }
    let!(:transactions) { create_list :transaction, 3, account: account }

    subject { get :show, params: { id: account.external_id, connection_id: connection.external_id } }

    before do
      allow_any_instance_of(described_class).to receive(:list_transactions).and_return(list_transactions)
    end

    context 'with authorized user' do
      before do
        auth_request(user)
        subject
      end

      it 'renders transactions' do
        expect(response).to have_http_status :ok
        data = Oj.load(response.body)
        expect(data['transactions'].size).to eq 3
      end
    end

    context 'with unauthorized user' do
      before do
        subject
      end

      it 'renders 401' do
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
