class Cart < ApplicationRecord
  include AuditActor

  belongs_to :account
  belongs_to :payment
  belongs_to :shipping_information
  belongs_to :billing_information

  validates_presence_of :checkout_state

  state_machine :checkout_state, initial: :fresh do
    audit_trail initial: false, context: :audit_actor_id

    event :ask_for_shipping do
      transition to: :shipping, unless: :shipping_information?
    end

    event :ask_for_billing do
      transition to: :billing, unless: :billing_information?
    end

    event :ask_for_payment do
      transition to: :payment, unless: :payment?
    end

    event :complete do
      transition from: all - [:fresh], to: :completed, if: :has_all_information?
    end
  end

  private def has_all_information?
    billing_information? && shipping_information? && payment?
  end
end
