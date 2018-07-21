class CartItem < ApplicationRecord
  PAPER_TRAIL_MODEL = "PublicVersion".freeze
  include(AuditedTransitions)

  belongs_to(:cart)
  belongs_to(:account)
  belongs_to(:product)

  monetize(:price_cents)
  monetize(:discount_cents)

  state_machine(:purchase_state, :initial => :pending) do
    event(:purchase) do
      transition(:pending => :purchased)
    end

    event(:returned) do
      transition(:purchased => :returned)
    end

    before_transition(:do => :version_transition)
  end

  def carbon_copy
    raise(CartItemAlreadyFinalized, self) unless purchase_state?(:pending)

    assign_attributes(:price => product.price)
  end
end
