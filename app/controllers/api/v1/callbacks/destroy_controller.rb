# frozen_string_literal: true

module Api
  module V1
    module Callbacks
      class DestroyController < Api::V1::Callbacks::BaseController
        def create
          connection&.destroy!
          head :ok
        end

        private

        def connection
          return @connection if defined? @connection

          @connection = Connection.find_by(
            external_id: params.require(:data).fetch(:connection_id)
          )
        end
      end
    end
  end
end
