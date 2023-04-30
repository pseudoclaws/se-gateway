# frozen_string_literal: true

class ConnectionCreatedJob
  include Sidekiq::Job

  queue_as :default

  def perform(customer_id, connection_id)
    customer = Customer.find_by(external_id: customer_id)
    return if customer.blank?

    create_connection.call(customer, connection_id)
  end

  private

  def create_connection
    @create_connection ||= Rails.configuration.container.resolve('se_api.connections.retrieve')
  end
end
