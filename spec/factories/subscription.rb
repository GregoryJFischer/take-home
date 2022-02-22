FactoryBot.define do
  factory :subscription do
    title {Faker::Lorem.sentence}
    frequency {Faker::Number.number(digits: 1)}
    customer
  end
end