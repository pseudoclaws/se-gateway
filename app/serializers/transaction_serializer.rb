class TransactionSerializer
  include JSONAPI::Serializer
  attributes :external_id, :mode, :status,
             :made_on, :amount, :currency_code, :description, :updated_at
end
