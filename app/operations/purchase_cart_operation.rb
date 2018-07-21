class PurchaseCartOperation < ApplicationOperation
  task(:check_for_payments)
  task(:switch_to_subtypes)
  task(:associate_to_cart)
  task(:allocate_funds)
  task(:lock)
  task(:purchase)
  task(:charge)
  task(:unlock)
  catch(:reraise)

  schema(:check_for_payments) do
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
  end
  def check_for_payments(state:)
    raise(NoPaymentsProvidedError) unless state.payments.any?
  end

  schema(:switch_to_subtypes) do
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
    field(:cart, :type => Types.Instance(Cart))
  end
  def switch_to_subtypes(state:)
    fresh(:state => {:payments => state.payments.map(&:morph), :cart => state.cart})
  end

  schema(:associate_to_cart) do
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
    field(:cart, :type => Types.Instance(Cart))
  end
  def associate_to_cart(state:)
    state.payments.each do |payment|
      payment.assign_attributes(:cart => state.cart)
    end
  end

  schema(:allocate_funds) do
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
    field(:cart, :type => Types.Instance(Cart))
  end
  def allocate_funds(state:)
    state.payments.sort_by(&:preference).reduce(state.cart.total_cents) do |remaining_cents, payment|
      break if remaining_cents.zero?

      if payment.maximum_allowed_cents >= remaining_cents
        payment.update!(:paid_cents => remaining_cents)
      else
        payment.update!(:paid_cents => remaining_cents - payment.maximum_allowed_cents)
      end

      payment.update!(:paid_currency => state.cart.total_currency)

      next remaining_cents - payment.maximum_allowed_cents
    end

    raise(NotEnoughMoneyProvidedError) if state.payments.sum(&:paid_cents) < state.cart.total_cents
  end

  schema(:lock) do
    field(:cart, :type => Types.Instance(Cart))
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
  end
  def lock(state:)
    database_lock!(:resource => state.cart)

    state.payments.each do |payment|
      database_lock!(:resource => payment)
    end

    state.cart.cart_items.map(&:product).uniq.each do |product|
      global_lock!(:resource => product, :name => :purchasing, :expires_in => 1.minute)
    end
  end

  schema(:purchase) do
    field(:cart, :type => Types.Instance(Cart))
  end
  def purchase(state:)
    state.cart.transaction do
      state.cart.purchase!
      CartItem.transaction(:requires_new => true) do
        state.cart.cart_items.each(&:purchase!)
      end
    end
  end

  schema(:charge) do
    field(:payments, :type => Types::Strict::Array.of(Types.Instance(Payment)))
  end
  def charge(state:)
    Payment.transaction do
      state.payments.each(&:charge!)
    end
  end

  schema(:unlock) do
    field(:cart, :type => Types.Instance(Cart))
  end
  def unlock(state:)
    state.cart.cart_items.map(&:product).uniq.each do |product|
      global_unlock!(:resource => product, :name => :purchasing)
    end
  end
end
