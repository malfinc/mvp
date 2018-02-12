class Payment < ApplicationRecord
  has_one :cart

  validates_presence_of :external_id
  validates_presence_of :subtype
  validates_inclusion_of :subtype, in: ["StripePayment"]
end
