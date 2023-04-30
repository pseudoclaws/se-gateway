FactoryBot.define do
  factory :connection do
    customer
    provider_id { "PROVIDER_ID" }
    sequence(:external_id) { |n| "EXTERNAL_ID#{n}" }
    secret { 'SECRET' }
    provider_code { 'PROVIDER_CODE' }
    provider_name { 'provider_name' }
    created_at { Time.current }
    updated_at { Time.current }
    status { 'active' }
    daily_refresh { false }
    store_credentials { true }
    show_consent_confirmation { true }
    last_attempt { {} }
  end
end
