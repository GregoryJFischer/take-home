class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas, dependent: :delete_all
  has_many :teas, through: :subscription_teas

  enum status: { "active" => 0,
    "cancelled" => 1
  }

  enum frequency: { "weekly" => 0,
    "monthly" => 1,
    "bianually" => 2
  }
end