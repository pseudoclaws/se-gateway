# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    user
    secret { 'SECRET' }
    sequence(:external_id) { |n| "EXTERNAL_ID#{n}" }
    sequence(:identifier) { |n| "IDENTIFIER#{n}" }
  end
end
