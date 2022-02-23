require 'rails_helper'

describe SubscriptionSerializer do
  it 'serializes a subscription' do
    subscription = create(:subscription)

    tea_1 = create(:tea)
    tea_2 = create(:tea)
    tea_3 = create(:tea)

    create(:subscription_tea, subscription: subscription, tea: tea_1)
    create(:subscription_tea, subscription: subscription, tea: tea_2)
    create(:subscription_tea, subscription: subscription, tea: tea_3)

    serializer = SubscriptionSerializer.one(subscription)

    expect(serializer[:data][:id]).to eq subscription.id
    expect(serializer[:data][:title]).to eq subscription.title
    expect(serializer[:data][:status]).to eq subscription.status
    expect(serializer[:data][:frequency]).to eq subscription.frequency
    expect(serializer[:data][:price]).to be_a Integer

    expect(serializer[:data][:teas]).to be_a Array
    expect(serializer[:data][:teas].length).to eq 3

    expect(serializer[:data][:teas][0][:id]).to eq tea_1.id
    expect(serializer[:data][:teas][0][:title]).to eq tea_1.title
    expect(serializer[:data][:teas][0][:description]).to eq tea_1.description
    expect(serializer[:data][:teas][0][:temperature]).to eq tea_1.temperature
    expect(serializer[:data][:teas][0][:brew_time]).to eq tea_1.brew_time
  end

  it 'serializes a group of subscriptions' do
    subscription = create(:subscription)
    create_list(:subscription, 3)

    tea_1 = create(:tea)
    tea_2 = create(:tea)
    tea_3 = create(:tea)

    create(:subscription_tea, subscription: subscription, tea: tea_1)
    create(:subscription_tea, subscription: subscription, tea: tea_2)
    create(:subscription_tea, subscription: subscription, tea: tea_3)

    serializer = SubscriptionSerializer.many(Subscription.all)

    expect(serializer[:data]).to be_a Array
    expect(serializer[:data].length).to eq 4

    expect(serializer[:data][0][:id]).to eq subscription.id
    expect(serializer[:data][0][:title]).to eq subscription.title
    expect(serializer[:data][0][:status]).to eq subscription.status
    expect(serializer[:data][0][:frequency]).to eq subscription.frequency
    expect(serializer[:data][0][:price]).to be_a Integer

    expect(serializer[:data][0][:teas]).to be_a Array
    expect(serializer[:data][0][:teas].length).to eq 3

    expect(serializer[:data][0][:teas][0][:id]).to eq tea_1.id
    expect(serializer[:data][0][:teas][0][:title]).to eq tea_1.title
    expect(serializer[:data][0][:teas][0][:description]).to eq tea_1.description
    expect(serializer[:data][0][:teas][0][:temperature]).to eq tea_1.temperature
    expect(serializer[:data][0][:teas][0][:brew_time]).to eq tea_1.brew_time
  end
end