class CartItem < ApplicationRecord

  validates_presence_of :price
  validates_presence_of :price_cents
  validates_presence_of :price_currency
end
