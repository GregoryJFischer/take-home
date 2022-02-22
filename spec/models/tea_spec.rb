require 'rails_helper'

describe Tea, type: :model do
  describe 'relationships' do
    it {should have_many :subscription_teas}
    it {should have_many(:subscriptions).through(:subscription_teas)}
  end

  it 'can create a tea' do
    tea = create(:tea)

    expect(tea.title).to be_a String
    expect(tea.description).to be_a String
    expect(tea.temperature).to be_a Integer
    expect(tea.brew_time).to be_a Integer
  end
end