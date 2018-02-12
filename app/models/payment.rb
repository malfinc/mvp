class Payment < ApplicationRecord
  belongs_to :account
  has_one :cart

  validates_presence_of :subtype
  validates_inclusion_of :subtype, in: ["StripePayment"]
  validates_presence_of :service_eid

  attr_accessor :current_account
  attr_accessor :current_cart

  before_validation :associate_current_account
  before_validation :associate_current_cart

  state_machine :processing_state, initial: :pending do
    event :complete do
      transition from: :pending, to: :completed
    end
  end

  private def associate_current_account
    assign_attributes(account: account || current_account)
  end

  private def associate_current_cart
    assign_attributes(cart: cart || current_cart)
    (cart || current_cart).assign_attributes(payment: self)
  end
end
