require 'rails_helper'

describe SubscriptionTea, type: :model do
  describe 'relationships' do
    it {should belong_to :tea}
    it {should belong_to :subscription}
  end

  it 'can create a new subscription_tea' do
    subscription_tea = create(:subscription_tea)

    expect(subscription_tea.price).to be_a Integer
    expect(subscription_tea.quantity).to be_a Integer
  end

  describe 'class methods' do
    describe '.total_price' do
      it 'returns the total price of the subscription' do
        create(:subscription_tea, price: 10, quantity: 1)
        create(:subscription_tea, price: 20, quantity: 1)
        create(:subscription_tea, price: 10, quantity: 2)

        expect(SubscriptionTea.total_price).to eq 50
      end
    end
  end
end