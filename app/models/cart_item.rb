class CartItem < ApplicationRecord
  include AuditActor

  belongs_to :cart
  belongs_to :account
  belongs_to :product

  monetize :price_cents

  before_validation :copy_price_cents
  before_validation :copy_price_currency
  before_validation :associate_current_cart
  before_validation :associate_current_account

  validates_presence_of :price
  validates_presence_of :price_cents
  validates_presence_of :price_currency

  state_machine :purchase_state, initial: :pending do
    audit_trail initial: false, context: :audit_actor_id

    event :purchase do
      transition :pending => :purchased
    end
  end

  attr_accessor :current_account
  attr_accessor :current_cart

  private def copy_price_cents
    assign_attributes(price_cents: product.price_cents)
  end

  private def copy_price_currency
    assign_attributes(price_currency: product.price_currency)
  end

  private def associate_current_cart
    assign_attributes(cart: current_cart)
  end

  private def associate_current_account
    assign_attributes(account: current_account)
  end
end
