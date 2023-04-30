# frozen_string_literal: true

class RefreshConnectionsJob
  include Sidekiq::Job

  queue_as :default

  def perform
    connections_query.in_batches do |connections|
      connections.each { |connection| RefreshConnectionJob.perform_async(connection.id) }
    end
  end

  private

  def connections_query
    Connection
      .where(next_refresh_possible_at: nil)
      .or(Connection.where('next_refresh_possible_at <= ?', Time.current.utc))
  end
end
