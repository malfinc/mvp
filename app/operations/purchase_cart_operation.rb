class PurchaseCartOperation < ApplicationOperation
  try :validate, catch: StandardError
  try :purchase, catch: StandardError
  try :persist, catch: StandardError

  def validate(payments:, cart:)
    raise NoPaymentsProvidedError unless payments.any?

    Success(payments: payments, cart: cart)
  end

  def purchase(payments:, cart:)
    payments.sort_by(&:preference).reduce(cart.total_cents) do |remaining_cents, payment|
      break if remaining_cents.zero?

      if payment.maximum_allowed_cents >= remaining_cents
        payment.assign_attributes(paid_cents: remaining_cents)
      else
        payment.assign_attributes(paid_cents: remaining_cents - payment.maximum_allowed_cents)
      end

      payment.assign_attributes(paid_currency: cart.total_currency)

      next remaining_cents - payment.maximum_allowed_cents
    end

    raise NotEnoughMoneyProvidedError if payments.sum(&:paid_cents) < cart.total_cents

    Success(payments: payments)
  end

  def persist(payments:)
    Payment.transaction do
      payments.each(&:save!)
    end
  end
end
