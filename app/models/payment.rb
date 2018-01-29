class Payment < ApplicationRecord
  has_one :cart

  validate_presence_of :type
  validates_inclusion_of :type, in: ["StripePayment"]
  validate_presence_of :external_id
end
