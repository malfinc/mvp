class PurchaseCartOperation < ApplicationOperation
  task :check_for_payments
  task :switch_to_subtypes
  task :associate_to_cart
  task :allocate_funds
  task :lock
  task :purchase
  task :persist
  task :charge
  task :unlock
  error :reraise

  schema :check_for_payments do
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
  end
  def check_for_payments(state:)
    raise NoPaymentsProvidedError unless state.payments.any?
  end

  schema :switch_to_subtypes do
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
    field :cart, type: Types.Instance(Cart)
  end
  def switch_to_subtypes(state:)
    fresh(payments: state.payments.map(&:morph), cart: state.cart)
  end

  schema :associate_to_cart do
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
    field :cart, type: Types.Instance(Cart)
  end
  def associate_to_cart(state:)
    state.payments.each do |payment|
      payment.update_attributes!(cart: state.cart)
    end
  end

  schema :allocate_funds do
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
    field :cart, type: Types.Instance(Cart)
  end
  def allocate_funds(state:)
    state.payments.sort_by(&:preference).reduce(state.cart.total_cents) do |remaining_cents, payment|
      break if remaining_cents.zero?

      if payment.maximum_allowed_cents >= remaining_cents
        payment.update_attributes!(paid_cents: remaining_cents)
      else
        payment.update_attributes!(paid_cents: remaining_cents - payment.maximum_allowed_cents)
      end

      payment.update_attributes!(paid_currency: state.cart.total_currency)

      next remaining_cents - payment.maximum_allowed_cents
    end

    raise NotEnoughMoneyProvidedError if state.payments.sum(&:paid_cents) < state.cart.total_cents
  end

  schema :lock do
    field :cart, type: Types.Instance(Cart)
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
  end
  def lock(state:)
    GlobalLockOperation.(resource: state.cart, type: :row)

    payments.each do |payment|
      GlobalLockOperation.(resource: payment, type: :row)
    end

    state.cart.cart_items.map(&:product).each do |product|
      GlobalLockOperation.(resource: product, type: :soft, name: "purchasing", expires_in: 1.minute)
    end
  end

  schema :purchase do
    field :cart, type: Types.Instance(Cart)
  end
  def purchase(state:)
    binding.pry
    state.cart.transaction do
      state.cart.purchase!
      CartItem.transaction requires_new: true do
        state.cart.cart_items.each(&:purchase!)
      end
    end
  end

  schema :charge do
    field :payments, type: Types::Strict::Array.of(Types.Instance(Payment))
  end
  def charge(state:)
    Payment.transaction do
      state.payments.each(&:charge!)
    end
  end

  schema :unlock do
    field :cart, type: Types.Instance(Cart)
  end
  def unlock(state:)
    GlobalUnlockOperation.(resource: state.cart)
  end
end
