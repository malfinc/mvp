class ShippingRate < ApplicationComputed
  attr_accessor :address

  def amount_cents
    15_00
  end
end
