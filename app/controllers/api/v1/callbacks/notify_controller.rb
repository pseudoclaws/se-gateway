# frozen_string_literal: true

module Api
  module V1
    module Callbacks
      class NotifyController < Api::V1::Callbacks::BaseController
        def create
          Rails.logger.info("Received params: #{params}")
          head :ok
        end
      end
    end
  end
end
