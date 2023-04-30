# frozen_string_literal: true

module SeApi
  module Customers
    class Create < SeApi::Base
      include AutoInject[
        list_customer: 'se_api.customers.list',
        request: 'se_api.request'
      ]

      API_PATH = '/api/v5/customers'

      def call(user)
        payload = { data: { identifier: user.email } }
        response = request.call(:post, API_PATH, payload)
        case response.status
        when 409
          list_customer.call(user)
        when 200
          process_data!(user, response.body['data'])
        else
          user.fail!
          check_response_status!(response) # raises an exception
        end
      end

      private

      def process_data!(user, data)
        ActiveRecord::Base.transaction do
          customer = Customer.create!(
            user:,
            identifier: data['identifier'],
            external_id: data['id'],
            secret: data['secret'],
            )
          user.finish!
          customer
        end
      end
    end
  end
end
