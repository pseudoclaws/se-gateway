# frozen_string_literal: true

class ConnectionSessionSerializer
  include JSONAPI::Serializer
  attributes :connect_url, :expires_at
end
