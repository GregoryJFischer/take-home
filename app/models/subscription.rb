class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :subscription_teas, dependent: :delete_all
  has_many :teas, through: :subscription_teas
end