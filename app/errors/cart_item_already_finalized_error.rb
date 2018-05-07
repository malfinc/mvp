class CartItemAlreadyFinalized < ApplicationError
  def status
    422
  end

  def detail
    "this cart item was already purchased and can't be changed"
  end
end
