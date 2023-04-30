# frozen_string_literal: true

module Api
  module V1
    module Callbacks
      class BaseController < ApplicationController
        skip_before_action :verify_authenticity_token

        http_basic_authenticate_with(
          name: CALLBACK_AUTH_USERNAME,
          password: CALLBACK_AUTH_PASSWORD
        )
      end
    end
  end
end
