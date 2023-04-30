# frozen_string_literal: true

module SeApi
  class Request
    include AutoInject[
      get_connection: 'utils.create_http_connection'
    ]

    API_REQUEST_HEADERS = {
      'App-id' => SALT_EDGE_APP_ID,
      'Secret' => SALT_EDGE_SECRET
    }.freeze

    def call(method, path, request_data = {})
      check_method!(method)

      get_connection.call.public_send(method, path, request_data, **API_REQUEST_HEADERS)
    end

    private

    def check_method!(method)
      return if method.in? %i[get post put delete]

      raise ArgumentError, 'method should be one of :get, :post, :put, :delete'
    end
  end
end
