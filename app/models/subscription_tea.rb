class SubscriptionTea < ApplicationRecord
  belongs_to :subscription
  belongs_to :tea

  def self.total_price
    sum("price * quantity")
  end
end