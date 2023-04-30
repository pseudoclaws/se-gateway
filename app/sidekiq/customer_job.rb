# frozen_string_literal: true

class CustomerJob
  include Sidekiq::Job

  queue_as :default

  def perform(user_id)
    user = User.find_by(id: user_id)
    return if user.blank? || user.customer_state.in?(%w[in_progress finished])

    user.run!
    begin
      create_customer.call(user)
    rescue ApplicationController::GatewayApiException, Faraday::ConnectionFailed => e
      user.fail!
      raise e
    end
  end

  private

  def create_customer
    @create_customer ||= Rails.configuration.container.resolve('se_api.customers.create')
  end
end
