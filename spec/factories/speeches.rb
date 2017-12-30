FactoryBot.define do
  factory :speech do
    association :script
    url { Faker::Internet.url }
  end
end
