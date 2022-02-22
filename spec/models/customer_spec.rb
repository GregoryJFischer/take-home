require 'rails_helper'

describe Customer, type: :model do
  describe 'relationships' do
    it {should have_many :subscriptions}
  end

  describe 'validations' do
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end

  it 'can create a customer' do
    customer = create(:customer)

    expect(customer.email).to be_a String
    expect(customer.first_name).to be_a String
    expect(customer.last_name).to be_a String
    expect(customer.address).to be_a String
  end
end