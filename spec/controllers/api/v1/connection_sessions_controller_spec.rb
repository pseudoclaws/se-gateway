# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::ConnectionSessionsController do
  describe 'POST #create' do
    let(:create_connect_session) { spy call: build(:connection_session) }

    subject { post :create, params: {}, as: :json }

    before do
      allow_any_instance_of(described_class)
        .to receive(:create_connect_session).and_return(create_connect_session)
    end

    context 'with authorized user' do
      let(:user) { create :user, :with_customer }
      before do
        auth_request(user)
        subject
      end

      it 'renders transactions' do
        expect(response).to have_http_status :created
        data = Oj.load(response.body)
        expect(data['connect_session']).to be
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
