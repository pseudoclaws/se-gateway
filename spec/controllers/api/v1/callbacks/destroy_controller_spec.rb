# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Callbacks::DestroyController do
  describe 'POST #create' do
    let(:data) do
      {
        "data": {
          "connection_id": "111111111111111111",
          "customer_id": "222222222222222222"
        },
        "meta": {
          "version": "5",
          "time": "2023-04-13T08:36:41Z"
        }
      }
    end

    context 'with valid auth data' do
      let!(:connection) { create :connection, external_id: '111111111111111111' }

      before do
        http_login
      end

      it 'returns 200' do
        post :create, params: data, as: :json
        expect(response).to have_http_status :ok
        expect(Connection.take).not_to be
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
