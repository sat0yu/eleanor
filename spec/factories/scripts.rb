FactoryBot.define do
  factory :script do
    title       { Faker::StarWars.quote }
    description { Faker::StarWars.quote }
    body        { Faker::StarWars.quote }
    length      { body&.length || 0 }
  end
end
