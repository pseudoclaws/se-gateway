# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::Callbacks::FailController do
  describe 'POST #create' do
    context 'with valid credentials' do
      before { http_login }
      it 'renders 200 OK' do
        post :create, params: {}, as: :json
        expect(response).to have_http_status :ok
      end
    end

    context 'with invalid credentials' do
      it 'renders 401 Unauthorized' do
        post :create, params: {}, as: :json
        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
