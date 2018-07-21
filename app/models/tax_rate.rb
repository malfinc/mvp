class TaxRate < ApplicationComputed
  attr_accessor(:address)

  def percent
    0.10
  end
end
