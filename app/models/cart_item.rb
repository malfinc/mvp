class CartItem < ApplicationRecord
  include AuditActor

  belongs_to :cart
  belongs_to :account
  belongs_to :product

  monetize :price_cents

  validates_presence_of :price
  validates_presence_of :price_cents
  validates_presence_of :price_currency

  state_machine :purchase_state, initial: :pending do
    audit_trail initial: false, context: :audit_actor_id

    event :purchase do
      transition :pending => :purchased
    end
  end
end
