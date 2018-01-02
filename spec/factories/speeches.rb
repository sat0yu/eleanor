FactoryBot.define do
  factory :speech do
    association :script
    url  { Faker::Internet.url }
    size { url&.size || 0 }
  end
end
