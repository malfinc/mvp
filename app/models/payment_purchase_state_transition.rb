class PaymentPurchaseStateTransition < ApplicationRecord
  belongs_to :payment

  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
end
