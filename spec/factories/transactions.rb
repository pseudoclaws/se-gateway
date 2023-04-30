FactoryBot.define do
  factory :transaction do
    account
    sequence(:external_id) { |n| "EXTERNAL_ID#{n}" }
    account_id { '' }
    duplicated { false }
    mode { 'normal' }
    status { 'pending' }
    made_on { Date.current }
    amount { '9.9' }
    currency_code { 'USD' }


    created_at { Time.current }
    updated_at { Time.current }
    extra { {} }
  end
end
