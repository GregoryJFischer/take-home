class SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create!(subscription_params)

    SubscriptionFacade.add_teas(subscription, params[:teas])

    render json: SubscriptionSerializer.one(subscription), status: 201
  end

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

  private

  def subscription_params
    params.permit(:customer_id, :frequency, :title)
  end
end