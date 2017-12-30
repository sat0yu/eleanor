FactoryBot.define do
  factory :script do
    title { Faker::StarWars.quote }
    body  { Faker::StarWars.quote }
  end
end
