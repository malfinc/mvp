class PaymentPurchaseStateTransition < ApplicationRecord
  belongs_to :payment

  validates_presence_of :namespace
  validates_presence_of :from
  validates_presence_of :to
end
