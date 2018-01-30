class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :account
  belongs_to :product

  validates_presence_of :price
  validates_presence_of :price_cents
  validates_presence_of :price_currency
end
