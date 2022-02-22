FactoryBot.define do
  factory :subscription_tea do
    price {Faker::Number.number(digits: 4)}
    quantity {Faker::Number.number(digits: 1)}
    subscription
    tea
  end
end