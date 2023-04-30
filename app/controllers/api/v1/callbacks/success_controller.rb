# frozen_string_literal: true

module Api
  module V1
    module Callbacks
      class SuccessController < Api::V1::Callbacks::BaseController
        def create
          ConnectionCreatedJob.perform_async(
            connection_params[:customer_id],
            connection_params[:connection_id]
          )
          head :ok
        end

        private

        def connection_params
          params.require(:data).permit(:connection_id, :customer_id)
        end
      end
    end
  end
end
