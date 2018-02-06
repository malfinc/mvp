class Cart < ApplicationRecord
  include AuditActor

  belongs_to :account
  belongs_to :payment, optional: true
  belongs_to :shipping_information, optional: true
  belongs_to :billing_information, optional: true

  validates_presence_of :checkout_state
  validates_presence_of :shipping_information, if: ->(record) { record.checkout_state?(:purchased) }
  validates_presence_of :shipping_information_id, if: ->(record) { record.checkout_state?(:purchased) }
  validates_presence_of :billing_information, if: ->(record) { record.checkout_state?(:purchased) }
  validates_presence_of :billing_information_id, if: ->(record) { record.checkout_state?(:purchased) }

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

    event :purchase do
      transition to: :purchased, if: :has_all_information?
    end
  end

  private def has_all_information?
    billing_information? && shipping_information? && payment?
  end
end
