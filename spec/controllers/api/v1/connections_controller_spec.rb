# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ConnectionsController do
  shared_examples :unauthorized_user do
    before { subject }

    it 'renders 401' do
      expect(response).to have_http_status :unauthorized
    end
  end

  shared_context :connection_setup do
    let(:user) { create :user, :with_customer }
    let(:connection) { create :connection, customer: user.customer }
  end

  describe 'GET #index' do
    let(:list_connections) { spy call: true }

    before do
      allow_any_instance_of(described_class)
        .to receive(:list_connections).and_return(list_connections)
    end

    subject { get :index }

    context 'with authorized user' do
      let(:user) { create :user, :with_customer }
      let!(:connections) { create_list :connection, 3, customer: user.customer }

      before do
        auth_request(user)
        subject
      end

      it 'renders available connections' do
        expect(response).to have_http_status :ok
        data = Oj.load(response.body)
        expect(data['connections'].size).to eq 3
      end

      context 'with failed gateway' do
        let(:list_connections) do
          lambda do |_|
            raise ApplicationController::GatewayApiException
                    .new('Something went wrong', 400)
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :ok
          data = Oj.load(response.body)
          expect(data['connections'].size).to eq 3
        end
      end

      context 'with failed http' do
        let(:list_connections) do
          lambda do |_|
            raise Faraday::ConnectionFailed
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :ok
          data = Oj.load(response.body)
          expect(data['connections'].size).to eq 3
        end
      end
    end

    it_behaves_like :unauthorized_user
  end

  describe 'GET #show' do
    subject { get :show, params: { id: connection.external_id } }
    include_context :connection_setup

    let(:list_accounts) { spy call: true }

    before do
      allow_any_instance_of(described_class)
        .to receive(:list_accounts).and_return(list_accounts)
    end

    context 'with authorized user' do
      let!(:accounts) { create_list :account, 3, connection: }

      before do
        auth_request(user)
        subject
      end

      it 'renders available connections' do
        expect(response).to have_http_status :ok
        data = Oj.load(response.body)
        expect(data['accounts'].size).to eq 3
      end

      context 'with failed gateway' do
        let(:list_accounts) do
          lambda do |_|
            raise ApplicationController::GatewayApiException
                    .new('Something went wrong', 400)
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :ok
          data = Oj.load(response.body)
          expect(data['accounts'].size).to eq 3
        end
      end

      context 'with failed http' do
        let(:list_accounts) do
          lambda do |_|
            raise Faraday::ConnectionFailed
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :ok
          data = Oj.load(response.body)
          expect(data['accounts'].size).to eq 3
        end
      end
    end

    it_behaves_like :unauthorized_user
  end

  describe 'PUT #update' do
    subject { put :update, params: { id: connection.external_id, reconnect: false }}

    let(:refresh_connection) { spy call: true }

    before do
      allow_any_instance_of(described_class)
        .to receive(:refresh_connection).and_return(refresh_connection)
    end

    include_context :connection_setup

    context 'with authorized user' do
      let!(:connection) { create :connection, customer: user.customer }

      before do
        auth_request(user)
        subject
      end

      it 'renders available connections' do
        expect(response).to have_http_status :ok
        data = Oj.load(response.body)
        expect(data['connection']).to be
      end

      context 'with failed gateway' do
        let(:refresh_connection) do
          lambda do |_, _|
            raise ApplicationController::GatewayApiException
                    .new('Something went wrong', 400)
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :bad_request
        end
      end

      context 'with failed http' do
        let(:refresh_connection) do
          lambda do |_, _|
            raise Faraday::ConnectionFailed
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :bad_gateway
        end
      end
    end

    it_behaves_like :unauthorized_user
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: connection.external_id } }

    let(:destroy_connection) { spy call: true }

    before do
      allow_any_instance_of(described_class)
        .to receive(:destroy_connection).and_return(destroy_connection)
    end

    include_context :connection_setup

    context 'with authorized user' do
      let!(:connection) { create :connection, customer: user.customer }

      before do
        auth_request(user)
        subject
      end

      it 'renders available connections' do
        expect(response).to have_http_status :ok
      end

      context 'with failed gateway' do
        let(:destroy_connection) do
          lambda do |_|
            raise ApplicationController::GatewayApiException
                    .new('Something went wrong', 400)
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :bad_request
        end
      end

      context 'with failed http' do
        let(:destroy_connection) do
          lambda do |_|
            raise Faraday::ConnectionFailed
          end
        end

        it 'renders available connections' do
          expect(response).to have_http_status :bad_gateway
        end
      end
    end

    it_behaves_like :unauthorized_user
  end
end
