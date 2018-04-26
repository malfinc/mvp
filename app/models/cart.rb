class Cart < ApplicationRecord
  include AuditedTransitions

  belongs_to :account
  has_one :shipping_information
  has_one :billing_information
  has_many :payments
  has_many :cart_items

  monetize :total_cents
  monetize :tax_cents
  monetize :shipping_cents
  monetize :discount_cents

  validates_presence_of :checkout_state

  state_machine :checkout_state, initial: :fresh do
    event :ask_for_shipping do
      transition to: :shipping, unless: :shipping_information?
    end

    event :ask_for_billing do
      transition to: :billing, unless: :billing_information?
    end

    event :ask_for_payment do
      transition to: :payment, unless: -> (record) { record.payments.any? }
    end

    event :purchase do
      transition to: :purchased, if: :has_all_information?
    end

    state :purchased do
      validates_presence_of :shipping_information
      validates_presence_of :shipping_information_id
      validates_presence_of :billing_information
      validates_presence_of :billing_information_id
      validates_presence_of :payments
    end

    before_transition do: :version_transition
  end

  def subtotal_cents
    return super if checkout_state?(:purchased)

    if cart_items.any?
      cart_items.sum(:price_cents) + cart_items.sum(:discount_cents)
    else
      0
    end
  end

  def discount_cents
    return super if checkout_state?(:purchased)

    read_attribute(:discount_cents) || 0
  end

  def tax_cents
    return super if checkout_state?(:purchased)

    if shipping_information.present?
      subtotal_cents * TaxRate.new(address: shipping_information).percent
    else
      0
    end
  end

  def shipping_cents
    return super if checkout_state?(:purchased)

    if shipping_information.present?
      ShippingRate.new(address: shipping_information).amount_cents
    else
      0
    end
  end

  def total_cents
    return super if checkout_state?(:purchased)

    if cart_items.any?
      subtotal_cents + discount_cents + tax_cents + shipping_cents
    else
      0
    end
  end

  private def has_all_information?
    billing_information? && shipping_information? && payments.any?
  end
end
