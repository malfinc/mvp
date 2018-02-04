class CartItemPurchaseStateTransition < ApplicationRecord
  belongs_to :cart_item

  validates_presence_of :event
  validates_presence_of :from
  validates_presence_of :to
end
