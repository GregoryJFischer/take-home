class SubscriptionFacade
  class << self
    def add_teas(subscription, teas)
      teas.each do |tea|
        SubscriptionTea.create!(subscription: subscription, tea: Tea.find(tea[:id]), price: tea[:price], quantity: tea[:quantity])
      end
    end
  end
end