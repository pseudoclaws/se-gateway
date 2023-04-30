# frozen_string_literal: true

class Api::V1::ConnectionSessionsController < Api::V1::BaseController
  include AutoInject[
    create_connect_session: 'se_api.connections.create_session'
  ]

  def create
    connect_session = create_connect_session.call(current_user)
    render json: {
      connect_session: ConnectionSessionSerializer.new(connect_session).serializable_hash
    }, status: :created
  end

  private

  def connection_sessions
    current_user.customer.connection_sessions.map do |cs|
      ConnectionSessionSerializer.new(cs).serializable_hash
    end
  end
end
