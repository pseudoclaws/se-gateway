FactoryBot.define do
  factory :connection_session do
    connect_url { "http://fake.url" }
    status { "pending" }
  end
end
