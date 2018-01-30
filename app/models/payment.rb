class Payment < ApplicationRecord
  has_one :cart

  validates_presence_of :type
  validates_inclusion_of :type, in: ["StripePayment"]
  validates_presence_of :external_id
end
