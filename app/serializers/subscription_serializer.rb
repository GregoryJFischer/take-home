class SubscriptionSerializer
  class << self
    def one(subscription)
      {
        data: {
          id: subscription.id,
          title: subscription.title,
          price: subscription.subscription_teas.total_price,
          status: subscription.status,
          frequency: subscription.frequency,
          teas: all_teas(subscription.teas)
        }
      }
    end

    def many(subscriptions)
      {
        data: subscriptions.map do |subscription|
          {
            id: subscription.id,
            title: subscription.title,
            price: subscription.subscription_teas.total_price,
            status: subscription.status,
            frequency: subscription.frequency,
            teas: all_teas(subscription.teas)
          }
        end
      }
    end

    def all_teas(teas)
      teas.map do |tea|
        {
          id: tea.id,
          title: tea.title,
          description: tea.description,
          temperature: tea.temperature,
          brew_time: tea.brew_time
        }
      end
    end
  end
end