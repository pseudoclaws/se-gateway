# frozen_string_literal: true

class FailedCustomersJob
  include Sidekiq::Job

  queue_as :default

  def perform
    users_query.in_batches do |users|
      users.each { |user| CustomerJob.perform_async(user.id) }
    end
  end

  private

  def users_query
    User.where(customer_state: %i[pending failed]).select(:id)
  end
end
