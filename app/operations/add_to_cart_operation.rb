class AddToCartOperation < ApplicationOperation
  step :validate
  step :associate
  check :persist

  def validate(cart_item:, cart:, account:)
    return Failure(CartItemWithoutProductError) unless cart_item.product.present?

    Success(cart_item: cart_item, cart: cart, account: account)
  end

  def associate(cart_item:, cart:, account:)
    cart_item.assign_attributes(
      cart: cart,
      account: account
    )

    cart_item.assign_attributes(
      price: cart_item.product.price
    )

    Success(cart_item: cart_item)
  end

  def persist(cart_item:)
    CartItem.transaction do
      cart_item.save!
    end
  end
end
