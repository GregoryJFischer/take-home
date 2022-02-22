require 'rails_helper'

describe Subscription, type: :model do
  describe 'relationships' do
    it {should belong_to :customer}
    it {should have_many :subscription_teas}
    it {should have_many(:teas).through(:subscription_teas)}
  end

  it 'can create a subscription' do
    subscription = create(:subscription)

    expect(subscription.title).to be_a String
    expect(subscription.status).to eq 0
    expect(subscription.frequency).to be_a Integer
  end
end