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
end