class Payment < ApplicationRecord
  include AuditedTransitions
  belongs_to :account
  has_one :cart

  validates_presence_of :subtype
  validates_inclusion_of :subtype, in: ["StripePayment"]
  validates_presence_of :service_eid

  state_machine :processing_state, initial: :pending do
    event :complete do
      transition from: :pending, to: :completed
    end

    before_transition do: :version_transition
  end
end
