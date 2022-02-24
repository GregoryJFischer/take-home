require 'rails_helper'

describe 'subscription requests' do
  before :each do
    @customer = create(:customer)

    @subscription_1 = create(:subscription, customer: @customer)
    @subscription_2 = create(:subscription, customer: @customer)

    @tea_1 = create(:tea)
    @tea_2 = create(:tea)
    @tea_3 = create(:tea)
    @tea_4 = create(:tea)
    @tea_5 = create(:tea)

    create(:subscription_tea, subscription: @subscription_1, tea: @tea_1)
    create(:subscription_tea, subscription: @subscription_1, tea: @tea_2)
    create(:subscription_tea, subscription: @subscription_2, tea: @tea_3)
    create(:subscription_tea, subscription: @subscription_2, tea: @tea_4)
    create(:subscription_tea, subscription: @subscription_2, tea: @tea_5)
  end

  describe 'GET /customers/:customer_id/subscriptions' do
    it 'can get a customers subscriptions' do
      get customer_subscriptions_path(@customer)

      body = JSON.parse(response.body, symbolize_names: true)
      data = body[:data]

      expect(response.status).to eq 200

      expect(data).to be_a Array
      expect(data.length).to eq 2

      expect(data[0][:id]).to eq @subscription_1.id
      expect(data[0][:title]).to eq @subscription_1.title
      expect(data[0][:status]).to eq @subscription_1.status
      expect(data[0][:frequency]).to eq @subscription_1.frequency

      expect(data[0][:teas]).to be_a Array
      expect(data[0][:teas].length).to eq 2

      expect(data[0][:teas][0][:id]).to eq @tea_1.id
      expect(data[0][:teas][0][:title]).to eq @tea_1.title
      expect(data[0][:teas][0][:description]).to eq @tea_1.description
      expect(data[0][:teas][0][:temperature]).to eq @tea_1.temperature
      expect(data[0][:teas][0][:brew_time]).to eq @tea_1.brew_time

      expect(data[1][:teas]).to be_a Array
      expect(data[1][:teas].length).to eq 3
    end

    it 'returns 404 if the customer is not found' do
      id = Customer.all.last.id + 1

      get "/customers/#{id}/subscriptions"

      expect(response.status).to eq 404
      expect(response.body).to match(/Couldn't find Customer with 'id'=/)
    end
  end

  describe 'DELETE /customers/:customer_id/subscriptions/:id' do
    it 'can delete a subscription' do
      id = @subscription_2.id
      delete "/customers/#{@customer.id}/subscriptions/#{id}"

      expect(response.status).to eq 204

      delete "/customers/#{@customer.id}/subscriptions/#{id}"

      expect(response.status).to eq 404
    end
  end

  describe 'POST /customers/:customer_id/subscriptions' do
    it 'can create a subscription' do
      params = {
        frequency: 'weekly',
        title: 'My Subscription',
        teas: [
          {
            id: @tea_1.id,
            price: 1,
            quantity: 2
          },
          {
            id: @tea_2.id,
            price: 3,
            quantity: 1
           }
        ]
      }

      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      post customer_subscriptions_path(@customer), params: params, as: :json, headers: headers

      subscription = Subscription.last

      body = JSON.parse(response.body, symbolize_names: true)
      data = body[:data]

      expect(response.status).to eq 201

      expect(data[:id]).to eq subscription.id
      expect(data[:title]).to eq subscription.title
      expect(data[:status]).to eq subscription.status
      expect(data[:frequency]).to eq subscription.frequency
      expect(data[:price]).to eq 5

      expect(data[:teas]).to be_a Array
      expect(data[:teas].length).to eq 2

      expect(data[:teas][0][:id]).to eq @tea_1.id
      expect(data[:teas][0][:title]).to eq @tea_1.title
      expect(data[:teas][0][:description]).to eq @tea_1.description
      expect(data[:teas][0][:temperature]).to eq @tea_1.temperature
      expect(data[:teas][0][:brew_time]).to eq @tea_1.brew_time
    end

    it 'returns an error if the params are invalid' do
      params = {
        frequency: 9,
        title: 'My Subscription',
        teas: [
          {
            id: @tea_1.id,
            price: 1,
            quantity: 2
          },
          {
            id: @tea_2.id,
            price: 3,
            quantity: 1
           }
        ]
      }

      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      post customer_subscriptions_path(@customer), params: params, as: :json, headers: headers

      expect(response.status).to eq 422
      expect(response.body).to match(/'9' is not a valid frequency/)
    end

    it 'returns an error if one of the teas is invalid' do
      params = {
        frequency: 'weekly',
        title: 'My Subscription',
        teas: [
          {
            id: @tea_1.id,
            price: 1,
            quantity: 2
          },
          {
            id: (@tea_5.id + 1),
            price: 3,
            quantity: 1
           }
        ]
      }

      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      post customer_subscriptions_path(@customer), params: params, as: :json, headers: headers

      expect(response.status).to eq 404
      expect(response.body).to match(/Couldn't find Tea with 'id'=/)
    end

    it 'returns an error if the customer id is invalid' do
      params = {
        frequency: 'weekly',
        title: 'My Subscription',
        teas: [
          {
            id: @tea_1.id,
            price: 1,
            quantity: 2
          },
          {
            id: @tea_2.id,
            price: 3,
            quantity: 1
           }
        ]
      }

      headers = {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }

      id = Customer.last.id + 1

      post "/customers/#{id}/subscriptions", params: params, as: :json, headers: headers

      expect(response.status).to eq 422
      expect(response.body).to match(/Validation failed: Customer must exist/)
    end
  end
end