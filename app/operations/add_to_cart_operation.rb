class AddToCartOperation < ApplicationOperation
  try :validate, catch: StandardError
  step :associate
  try :persist, catch: StandardError

  def validate(cart_item:)
    raise ProductMissingFromCartItemError unless cart_item.product.present?

    Success(cart_item: cart_item)
  end

  def associate(cart_item:)
    cart_item.assign_attributes(price: cart_item.product.price)

    Success(cart_item: cart_item)
  end

  def persist(cart_item:)
    CartItem.transaction do
      cart_item.save!
    end
  end
end
