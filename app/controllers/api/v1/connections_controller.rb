# frozen_string_literal: true

class Api::V1::ConnectionsController < Api::V1::BaseController
  include AutoInject[
    list_connections: 'se_api.connections.list',
    list_accounts: 'se_api.accounts.list',
    refresh_connection: 'se_api.connections.refresh',
    destroy_connection: 'se_api.connections.destroy'
  ]

  def index
    # I don't like the idea of calling this synchronously on every request
    # very much. This was made only as the first iteration.
    # Maybe we'll be able to move this call into background
    # or we'll be satisfied with the updates carried out by the cron job
    list_connections.call(current_user)
  rescue GatewayApiException, Faraday::ConnectionFailed
    outdated = true
  ensure
    render json: { connections:, outdated: }
  end

  def show
    list_accounts.call(connection)
  rescue GatewayApiException, Faraday::ConnectionFailed
    outdated = true
  ensure
    render json: { accounts:, outdated: }
  end

  def update
    refresh_connection.call(connection, reconnect)
    render json: { connection: ConnectionSerializer.new(connection).serializable_hash }
  end

  def destroy
    success = destroy_connection.call(connection)
    if success
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private

  def reconnect
    params.require(:reconnect)
  end

  def connection
    @connection ||= current_user.connections.find_by!(external_id: params[:id])
  end

  def connections
    current_user.connections.preload(:customer).map do |connection|
      ConnectionSerializer.new(connection).serializable_hash
    end
  end

  def accounts
    connection.accounts.preload(:connection).map do |acc|
      AccountSerializer.new(acc).serializable_hash
    end
  end
end
