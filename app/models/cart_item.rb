class CartItem < ApplicationRecord
  include AuditedTransitions

  belongs_to :cart
  belongs_to :account
  belongs_to :product

  monetize :price_cents

  validates_presence_of :price
  validates_presence_of :price_cents
  validates_presence_of :price_currency

  state_machine :purchase_state, initial: :pending do
    event :purchase do
      transition :pending => :purchased
    end

    before_transition do: :version_transition
  end
end
