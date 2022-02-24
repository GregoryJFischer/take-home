class SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions

    render json: SubscriptionSerializer.many(subscriptions)
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.subscription_teas.delete_all

    render json: subscription.delete, status: 204
  end
end