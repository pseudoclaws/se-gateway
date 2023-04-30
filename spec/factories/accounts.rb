FactoryBot.define do
  factory :account do
    connection { nil }
    sequence(:external_id) { |n| "EXTERNAL_ID#{n}" }
    nature { "card" }
    balance { "9.99" }
    currency_code { "USD" }
    created_at { "2023-04-30 12:40:44" }
    updated_at { "2023-04-30 12:40:44" }
    extra { {} }
    trait :with_connection do
      connection
    end
  end
end
