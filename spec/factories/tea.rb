FactoryBot.define do
  factory :tea do
    title {Faker::Lorem.word}
    description {Faker::Lorem.paragraph}
    temperature {Faker::Number.number(digits: 2)}
    brew_time {Faker::Number.number(digits: 3)}
  end
end