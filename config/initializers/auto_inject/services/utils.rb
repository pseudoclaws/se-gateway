# frozen_string_literal: true

Rails.configuration.container.namespace(:utils) do
  register :create_http_connection, -> { Utils::CreateHttpConnection.new }
end
