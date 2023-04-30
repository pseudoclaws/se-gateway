# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Callbacks::SuccessController, type: :controller do
  describe 'POST #create' do
    let(:data) do
      {
        data: {
          connection_id: "111111111111111111",
          customer_id: "222222222222222222",
          custom_fields: { key: "value" }
        },
        meta: {
          version: "5",
          time: "2023-04-14T08:36:41.226Z"
        }
      }
    end

    context 'with valid auth data' do
      before do
        allow(ConnectionCreatedJob).to receive(:perform_async)
        http_login
      end

      it 'returns 200' do
        post :create, params: data, as: :json
        expect(response).to have_http_status :ok
        expect(ConnectionCreatedJob)
          .to have_received(:perform_async).with("222222222222222222", "111111111111111111")
      end
    end

    context 'without valid auth data' do
      it 'returns 401' do
        post :create, params: data, as: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
