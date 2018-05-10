class ProductMissingFromCartItemError < ApplicationError
  def status
    422
  end

  def detail
    "a cart item must have a product"
  end
end
