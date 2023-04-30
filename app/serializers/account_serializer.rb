class AccountSerializer
  include JSONAPI::Serializer
  attributes :external_id, :nature, :balance, :currency_code, :updated_at
  attribute :connection_id do |object|
    object.connection.external_id
  end
end
