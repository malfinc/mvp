class PaymentPurchaseStateTransition < ApplicationRecord
  belongs_to :payment

  validate_presence_of :namespace
  validate_presence_of :from
  validate_presence_of :to
end
