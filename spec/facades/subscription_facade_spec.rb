require 'rails_helper'

describe SubscriptionFacade do
  before :each do
    @customer = create(:customer)

    @subscription = create(:subscription, customer: @customer)

    @tea_1 = create(:tea)
    @tea_2 = create(:tea)
    @tea_3 = create(:tea)
    @tea_4 = create(:tea)
  end

  describe 'add_teas' do
    it 'should add teas to subscription' do
      teas = [
        {
          id: @tea_1.id,
          price: 1,
          quantity: 1
        },
        {
          id: @tea_2.id,
          price: 1,
          quantity: 1
        },
        {
          id: @tea_3.id,
          price: 1,
          quantity: 1
        }
      ]
      SubscriptionFacade.add_teas(@subscription, teas)

      expect(@subscription.teas).to include(@tea_1)
      expect(@subscription.teas).to include(@tea_2)
      expect(@subscription.teas).to include(@tea_3)

      expect(@subscription.teas).to_not include(@tea_4)

      expect(@subscription.subscription_teas.total_price).to eq 3
    end
  end
end