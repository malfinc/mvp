class CartItemWithoutProductError < ApplicationError
  def status
    422
  end

  def as_errors
    [
      {
        "title" => "Cart Items Need Products",
        "detail" => "You can't add nothing to your cart."
      }
    ]
  end
end
