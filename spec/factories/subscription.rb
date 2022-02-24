FactoryBot.define do
  factory :subscription do
    title {Faker::Lorem.sentence}
    frequency {[0,1,2].sample}
    customer
  end
end