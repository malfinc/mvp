class CartCheckoutStateTransition < ApplicationRecord
  belongs_to :cart

  validate_presence_of :namespace
  validate_presence_of :from
  validate_presence_of :to
end
