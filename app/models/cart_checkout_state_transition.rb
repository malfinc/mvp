class CartCheckoutStateTransition < ApplicationRecord
  belongs_to :cart

  validates_presence_of :namespace
  validates_presence_of :from
  validates_presence_of :to
end
