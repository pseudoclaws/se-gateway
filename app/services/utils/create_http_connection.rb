# frozen_string_literal: true

module Utils
  class CreateHttpConnection
    def call
      Faraday.new(API_HOST) do |f|
        f.request :json # encode req bodies as JSON and automatically set the Content-Type header
        f.response :json # decode response bodies as JSON
      end
    end
  end
end
