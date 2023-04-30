class ConnectionSerializer
  include JSONAPI::Serializer
  attributes :external_id, :provider_name, :status, :updated_at

  attribute :customer_identifier do |object|
    object.customer.identifier
  end

  attribute :customer_id do |object|
    object.customer.external_id
  end
end
