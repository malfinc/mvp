class Payment < ApplicationRecord
  include AuditedTransitions

  # NOTE: Ordered by preference
  TYPES = [
    "GiftCardPayment",
    "CreditPayment",
    "StripePayment",
  ]

  belongs_to :account
  belongs_to :cart

  monetize :paid_cents

  validates_presence_of :subtype
  validates_inclusion_of :subtype, in: TYPES
  validates_presence_of :source_id

  state_machine :processing_state, initial: :pending do
    event :complete do
      transition from: :pending, to: :paid
    end

    event :refund do
      transition from: :paid, to: :refunded
    end

    state :refunded do
      monetize :refund_cents
    end

    before_transition do: :version_transition
  end

  def preference
    TYPES.index_of(subtype)
  end
end
