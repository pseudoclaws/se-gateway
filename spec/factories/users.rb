# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    customer { nil }
    email { Faker::Internet.email }
    password { 'password' }
    trait :with_customer do
      before(:create) do |record|
        record.customer = build(
          :customer,
          identifier: 'identifier',
          external_id: 'EXTERNAL_ID',
          secret: 'SECRET',
          created_at: Time.current,
          updated_at: Time.current
        )
      end
    end
  end
end
