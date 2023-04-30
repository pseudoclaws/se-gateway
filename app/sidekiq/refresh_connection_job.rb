# frozen_string_literal: true

class RefreshConnectionJob
  include Sidekiq::Job

  queue_as :default

  def perform(connection_id)
    connection = Connection.find_by(id: connection_id)
    return if connection.blank?

    begin
      refresh_connection.call(connection)
    rescue ApplicationController::GatewayApiException, Faraday::ConnectionFailed
      Rails.logger.info "Connection #{connection.external_id} refresh failed, skipping"
    end
  end

  private

  def refresh_connection
    @refresh_connection ||= Rails.configuration.container.resolve('se_api.connections.refresh')
  end
end
